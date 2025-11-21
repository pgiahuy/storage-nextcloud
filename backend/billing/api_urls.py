# billing/api_urls.py
from django.urls import path
from . import views

app_name = 'billing_api'

urlpatterns = [
    path('plans/', views.plan_list_create, name='plan_list_create'),
    path('plans/<int:pk>/', views.plan_detail, name='plan_detail'),
    path('available_plans/', views.api_available_plans, name='api_available_plans'),
    path('subscribe_plan/', views.api_subscribe_plan, name='api_subscribe_plan'),
]
