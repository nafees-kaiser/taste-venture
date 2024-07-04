from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.users_list, name='users_list'),
    path('profile/<str:email>/', views.get_user_details, name='user_details'),
]