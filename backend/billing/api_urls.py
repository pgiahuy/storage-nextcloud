from django.urls import path
from . import views

urlpatterns = [
    path('plans/', views.plan_list_create, name='api_plan_list_create'),
    path('plans/<int:pk>/', views.plan_detail, name='api_plan_detail'),
]
