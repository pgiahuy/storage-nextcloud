from django.urls import path
from . import views

app_name = 'users_api'

urlpatterns = [
    path('register/', views.register_user, name='register_user'),
    path('login/', views.login_user, name='login_user'),
    path('logout/', views.api_logout, name='logout_user'),
    path('subscribe/', views.subscribe_plan_api, name='subscribe_plan'),
    path('user/<int:user_id>/', views.api_user_info, name='user_info'),
]
