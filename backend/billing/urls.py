# billing/urls.py
from django.urls import path
from . import views

app_name = 'billing'
urlpatterns = [
    # Web views
    path('plans/', views.plan_list, name='plan_list'),
    path('plans/create/', views.plan_create, name='plan_create'),
    path('plans/<int:pk>/update/', views.plan_update, name='plan_update'),
    path('plans/<int:pk>/delete/', views.plan_delete, name='plan_delete'),
    path('plans/<int:pk>/subscribe/', views.subscribe_plan, name='subscribe_plan'),
    path('subscribe/success/', views.subscribe_success, name='subscribe_success'),
    path('vnpay/<int:plan_id>/', views.vnpay_payment, name='vnpay_payment'),
    path('vnpay_return/', views.vnpay_return, name='vnpay_return'),


]
