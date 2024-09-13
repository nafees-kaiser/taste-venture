from django.urls import path
from . import views

urlpatterns = [
    path('verify-otp', views.verify_otp, name='verify_otp'),
    path('update-password', views.update_password, name='update_password'),
    path('verify-email', views.verify_email, name='verify_email'),
]