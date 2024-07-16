from django.urls import path

from restaurant import views

urlpatterns = [
    path('add-menu', views.add_menu),
    path('edit-menu', views.edit_menu),
    path('add-restaurant', views.add_restaurant),
    path('add-restaurant-review', views.add_restaurant_review),
    path('<int:restaurant_id>/', views.restaurant_details, name='restaurant_details'),
    path('get-restaurant-reviews/<int:restaurant_id>', views.get_restaurant_reviews),
]