# billing/urls.py
from django.urls import path
from . import views

app_name = 'billing'

urlpatterns = [
    path('plans/', views.plan_list, name='plan_list'),
    path('subscribe/<int:pk>/', views.subscribe_plan, name='subscribe_plan'),
    path('subscribe/success/', views.subscribe_success, name='subscribe_success'),

    # Thanh toán VNPAY
    path('vnpay/payment/<int:plan_id>/', views.vnpay_payment, name='vnpay_payment'),
    path('vnpay_return/', views.vnpay_return, name='vnpay_return'),

    # CRUD Plan (Admin)
    path('admin/plan/create/', views.plan_create, name='plan_create'),
    path('admin/plan/update/<int:pk>/', views.plan_update, name='plan_update'),
    path('admin/plan/delete/<int:pk>/', views.plan_delete, name='plan_delete'),
]
