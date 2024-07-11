from django.urls import path
from . import views

urlpatterns = [

    path('profile/<str:email>/', views.get_user_details, name='user_details'),
    path('register', views.users_list, name='users_list'),
    path('login', views.login, name='login'),
    path('verify-otp', views.verify_otp, name='verify_otp'),
]
