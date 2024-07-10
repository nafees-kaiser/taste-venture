from django.urls import path

from tourspot import views

urlpatterns = [
    path('register-manager', views.add_manager, name='add_manager'),
]