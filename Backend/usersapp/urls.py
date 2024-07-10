from django.urls import path
from . import views

urlpatterns = [
    path('register', views.users_list, name='users_list'),
    path('login', views.login, name='login'),
]