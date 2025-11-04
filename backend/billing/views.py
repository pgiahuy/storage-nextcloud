from django.utils import timezone
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404, redirect
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from datetime import timedelta
from .decorators import admin_required
from .serializers import PlanSerializer
import hashlib
import hmac
import urllib.parse
import time
from .models import Plans, Subscriptions, Payments, Invoices

# VNPAY
VNPAY_TMN_CODE = ""
VNPAY_HASH_SECRET = ""
VNPAY_RETURN_URL = "http://127.0.0.1:8000/billing/vnpay_return/"
VNPAY_PAYMENT_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"



@login_required
def subscribe_plan(request, pk):
    plan = get_object_or_404(Plans, pk=pk)
    today = timezone.now().date()
    active_sub = Subscriptions.objects.filter(
        user=request.user, status='active', end_date__gte=today
    ).first()


    if active_sub:
        if plan.price > active_sub.plan.price:
            action = 'upgrade'
        elif plan.price < active_sub.plan.price:
            action = 'downgrade'
        else:
            action = 'current'
    else:
        action = 'register'

    #tính tổng
    if action == 'downgrade':
        payment_amount = 0
    elif action == 'upgrade':
        payment_amount = plan.price - active_sub.plan.price
    else:
        payment_amount = plan.price

    if request.method == 'POST':
        if payment_amount <= 0:
            # free -> skip vnpay
            if active_sub and action != 'current':
                active_sub.delete()
            Subscriptions.objects.create(
                user=request.user, plan=plan,
                start_date=today,
                end_date=today + timedelta(days=plan.duration_days),
                status='active'
            )
            return redirect('billing:subscribe_success')
        else:
            # fee -> vnpay
            return redirect('billing:vnpay_payment', plan_id=plan.id)

    return render(request, 'billing/subscribe_confirm.html', {
        'plan': plan,
        'active_sub': active_sub,
        'action': action,
        'payment_amount': payment_amount,
    })


@login_required
def vnpay_payment(request, plan_id):
    plan = get_object_or_404(Plans, id=plan_id)
    active_sub = Subscriptions.objects.filter(user=request.user, status='active').first()
    old_price = active_sub.plan.price if active_sub else 0
    diff_price = plan.price - old_price
    amount_vnd = diff_price * 1000
    amount = int(amount_vnd * 100)

    # tạo gd
    txn_ref = f'{request.user.id}_{plan.id}_{int(time.time())}'
    payment = Payments.objects.create(
        user=request.user,
        plan=plan,
        amount=diff_price,
        method='vnpay',
        status='pending',
        transaction_id=txn_ref
    )

    vnp_Params = {
        'vnp_Version': '2.1.0',
        'vnp_Command': 'pay',
        'vnp_TmnCode': VNPAY_TMN_CODE,
        'vnp_Amount': amount,
        'vnp_CreateDate': time.strftime('%Y%m%d%H%M%S'),
        'vnp_CurrCode': 'VND',
        'vnp_IpAddr': request.META.get('REMOTE_ADDR', '127.0.0.1'),
        'vnp_Locale': 'vn',
        'vnp_OrderInfo': f'Thanh toan goi {plan.name}',
        'vnp_OrderType': 'other',
        'vnp_ReturnUrl': VNPAY_RETURN_URL,
        'vnp_TxnRef': txn_ref,
    }

    #tạo chữ ký (HMAC-SHA512)
    sorted_params = {k: str(v) for k, v in sorted(vnp_Params.items()) if v}
    query_string = urllib.parse.urlencode(sorted_params)
    vnp_SecureHash = hmac.new(VNPAY_HASH_SECRET.encode('utf-8'),query_string.encode('utf-8'),hashlib.sha512).hexdigest()
    vnp_Params['vnp_SecureHash'] = vnp_SecureHash

    return redirect(VNPAY_PAYMENT_URL + '?' + urllib.parse.urlencode(vnp_Params))

def vnpay_return(request):
    vnp_ResponseCode = request.GET.get('vnp_ResponseCode')
    txn_ref = request.GET.get('vnp_TxnRef')  # VNPAY trả về

    try:

        payment = Payments.objects.get(transaction_id=txn_ref, method='vnpay')
    except Payments.DoesNotExist:
        return render(request, 'billing/payment_failed.html', {
            'message': 'Giao dịch không tồn tại.'
        })

    if vnp_ResponseCode == '00' and payment.status != 'success':
        # CẬP NHẬT THANH TOÁN
        payment.status = 'success'
        payment.transaction_id = request.GET.get('vnp_TransactionNo')  # Cập nhật mã VNPAY
        payment.save()

        # TẠO HÓA ĐƠN
        invoice_number = f"INV-{int(time.time())}"
        Invoices.objects.create(
            payment=payment,
            invoice_number=invoice_number,
            issue_date=timezone.now().date(),
            due_date=timezone.now().date(),
            total=payment.amount,
            status='paid'
        )

        # KÍCH HOẠT GÓI
        Subscriptions.objects.filter(user=payment.user, status='active').delete()
        Subscriptions.objects.create(
            user=payment.user,
            plan=payment.plan,
            start_date=timezone.now().date(),
            end_date=timezone.now().date() + timedelta(days=payment.plan.duration_days),
            status='active'
        )

        return render(request, 'billing/payment_success.html', {
            'message': f'Thanh toán thành công! Hóa đơn: {invoice_number}',
            'payment': payment
        })
    else:
        payment.status = 'failed'
        payment.save()
        return render(request, 'billing/payment_failed.html', {
            'message': 'Thanh toán thất bại.'
        })



@login_required
def subscribe_success(request):
    # Lấy gói vừa tạo
    latest_sub = Subscriptions.objects.filter(
        user=request.user,
        status='active'
    ).order_by('-start_date').first()

    return render(request, 'billing/subscribe_success.html', {
        'subscription': latest_sub
    })

@login_required
def plan_list(request):
    plans = Plans.objects.all().order_by('price')
    today = timezone.now().date()

    active_sub = Subscriptions.objects.filter(
        user=request.user,
        status='active',
        end_date__gte=today
    ).first()

    plan_list = []
    for plan in plans:
        if not active_sub:
            action = 'register'
        else:
            if plan.price > active_sub.plan.price:
                action = 'upgrade'
            elif plan.price < active_sub.plan.price:
                action = 'downgrade'
            else:
                action = 'current'
        plan_list.append({
            'plan': plan,
            'action': action
        })

    return render(request, 'billing/plan_list.html', {
        'plan_list': plan_list,
        'active_sub': active_sub
    })



# CRUD PLAN (ADMIN)
@login_required
@admin_required
def plan_create(request):
    # ... (giữ nguyên code của bạn)
    pass

@login_required
@admin_required
def plan_update(request, pk):
    # ... (giữ nguyên)
    pass

@login_required
@admin_required
def plan_delete(request, pk):
    # ... (giữ nguyên)
    pass


# API: PLAN LIST/CREATE
@api_view(['GET', 'POST'])
def plan_list_create(request):
    if request.method == 'GET':
        plans = Plans.objects.all()
        serializer = PlanSerializer(plans, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = PlanSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# API: PLAN DETAIL
@api_view(['GET', 'PUT', 'DELETE'])
def plan_detail(request, pk):
    try:
        plan = Plans.objects.get(pk=pk)
    except Plans.DoesNotExist:
        return Response({'error': 'Plan not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = PlanSerializer(plan)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = PlanSerializer(plan, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        plan.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)