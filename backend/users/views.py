import json
import uuid
from datetime import date, timedelta

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, logout, authenticate, get_user_model
from django.contrib.auth.hashers import make_password
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse

from billing.models import *

from backend.billing.models import Plans, Payments, Invoices, Subscriptions

User = get_user_model()

def index_view(request):
    return render(request, 'index.html')  # template index.html


def register_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        email = request.POST.get('email')
        full_name = request.POST.get('full_name', '')
        phone = request.POST.get('phone', '')
        role = request.POST.get('role', 'user')

        if User.objects.filter(username=username).exists():
            return render(request, 'users/register.html', {'error': 'User already exists'})

        user = User.objects.create(
            username=username,
            email=email,
            full_name=full_name,
            phone=phone,
            role=role,
            password=make_password(password)
        )
        login(request, user)
        return redirect('billing:plan_list')

    return render(request, 'users/register.html')


@csrf_exempt
def register_user(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')
        email = data.get('email')
        full_name = data.get('full_name', '')
        phone = data.get('phone', '')
        role = data.get('role', 'user')

        if User.objects.filter(username=username).exists():
            return JsonResponse({'message': 'User already exists'}, status=400)

        user = User.objects.create(
            username=username,
            email=email,
            full_name=full_name,
            phone=phone,
            role=role,
            password=make_password(password)
        )
        return JsonResponse({'message': f'User {user.username} created successfully'})

    return JsonResponse({'message': 'Invalid request'}, status=400)


def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user:
            login(request, user)
            return redirect('billing:plan_list')
        else:
            return render(request, 'users/login.html', {'error': 'Invalid credentials'})

    return render(request, 'users/login.html')


@csrf_exempt
def login_user(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')
        user = authenticate(username=username, password=password)
        if user:
            return JsonResponse({'message': 'Login successful', 'user_id': user.id})
        return JsonResponse({'message': 'Invalid credentials'}, status=400)
    return JsonResponse({'message': 'Invalid request'}, status=400)


@login_required
def logout_view(request):
    logout(request)
    return redirect('login')



@login_required
def subscribe_plan(request):
    if request.method == 'POST':
        plan_id = request.POST.get('plan_id')
        plan = get_object_or_404(Plans, id=plan_id)

        transaction_id = str(uuid.uuid4())
        payment = Payments.objects.create(
            user=request.user,
            amount=plan.price,
            method='demo',
            status='success',
            transaction_id=transaction_id
        )

        invoice = Invoices.objects.create(
            payment=payment,
            invoice_number=str(uuid.uuid4())[:8],
            issue_date=date.today(),
            due_date=date.today() + timedelta(days=plan.duration_days),
            total=plan.price,
            status='paid'
        )

        subscription = Subscriptions.objects.create(
            user=request.user,
            plan=plan,
            start_date=date.today(),
            end_date=date.today() + timedelta(days=plan.duration_days),
            status='active'
        )

        return redirect('plan_list')

    plans = Plans.objects.all()
    return render(request, 'billing/plan_list.html', {'plans': plans})


@csrf_exempt
def subscribe_plan_api(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Invalid request'}, status=400)

    data = json.loads(request.body)
    username = data.get('username')
    plan_id = data.get('plan_id')

    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'error': 'User not found'}, status=404)

    try:
        plan = Plans.objects.get(id=plan_id)
    except Plans.DoesNotExist:
        return JsonResponse({'error': 'Plan not found'}, status=404)

    transaction_id = str(uuid.uuid4())
    payment = Payments.objects.create(
        user=user,
        amount=plan.price,
        method='demo',
        status='success',
        transaction_id=transaction_id
    )

    invoice = Invoices.objects.create(
        payment=payment,
        invoice_number=str(uuid.uuid4())[:8],
        issue_date=date.today(),
        due_date=date.today() + timedelta(days=plan.duration_days),
        total=plan.price,
        status='paid'
    )

    subscription = Subscriptions.objects.create(
        user=user,
        plan=plan,
        start_date=date.today(),
        end_date=date.today() + timedelta(days=plan.duration_days),
        status='active'
    )

    return JsonResponse({
        'message': 'Subscription created successfully',
        'subscription_id': subscription.id,
        'invoice_number': invoice.invoice_number,
        'payment_id': payment.id
    })
