from django.urls import path
from . import views

app_name = 'users'

urlpatterns = [
    path('', views.index_view, name='index'),
    path('register/', views.register_view, name='register'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('subscribe/', views.subscribe_plan, name='subscribe_plan'),
]
