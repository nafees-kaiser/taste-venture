from django.urls import path
from . import views

urlpatterns = [
    path('register', views.register, name='users_list'),
    path('login', views.login, name='login'),
    path('verify-otp', views.verify_otp, name='verify_otp'),
    path('update-password', views.update_password, name='update_password'),
    path('get-user', views.get_user_details, name='get_user_details'),
    path('update-user-info', views.update_user_details, name='update_user_details'),
    path('verify-email', views.verify_email, name='verify_email'),
    path('view-favorite/<int:user_id>/', views.view_favorite, name='view_favorite'),
]