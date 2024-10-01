from django.urls import path
from . import views

urlpatterns = [
    path('register', views.register, name='users_list'),
    path('login', views.login, name='login'),
    path('get-user', views.get_user_details, name='get_user_details'),
    path('update-user-info', views.update_user_details, name='update_user_details'),
    path('view-favorite/<int:user_id>/', views.view_favorite, name='view_favorite'),
    path('add-to-favorite', views.add_to_favorite, name='add_to_favorite'),
    path('remove-from-favorite', views.remove_from_favorite, name='remove_from_favorite'),
    path('get-manager-info', views.get_manager_info, name='get_manager_info'),
    path('get-notifications/<int:user_id>', views.get_notifications, name='get_notifications'),
    path('add-notification', views.add_notification, name='add_notification'),
    path('remove-notification/<int:user_id>', views.delete_notification, name='remove_notification'),
]