from django.urls import path
from . import views

urlpatterns = [
    path('register', views.register, name='users_list'),
    path('login', views.login, name='login'),
    path('get-user/<int:user_id>', views.get_user_details, name='get_user_details'),
    path('update-user-info', views.update_user_details, name='update_user_details'),
    path('view-favorite/<int:user_id>/', views.view_favorite, name='view_favorite'),
    path('add-to-favorite', views.add_to_favorite, name='add_to_favorite'),
    path('remove-from-favorite', views.remove_from_favorite, name='remove_from_favorite'),
]