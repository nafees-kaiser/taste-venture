from django.urls import path

from tourspot import views

urlpatterns = [
    path('register-manager', views.add_manager, name='add_manager'),
    path('view-list', views.view_tourspot_list, name='view_tourspot_list'),
    path('view-list/<int:id>/', views.view_tourspot_detail, name='tourspot_detail'),
]