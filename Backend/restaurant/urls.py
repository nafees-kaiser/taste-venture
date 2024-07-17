from django.urls import path

from restaurant import views

urlpatterns = [
    path('add-menu', views.add_menu),
    path('edit-menu', views.edit_menu),
    path('view-menu/<int:restaurant_id>', views.view_menu, name='view_menu'),
    path('add-restaurant', views.add_restaurant),
    path('add-restaurant-review', views.add_restaurant_review),
    path('<int:restaurant_id>/', views.restaurant_details, name='restaurant_details'),
    path('get-restaurant-reviews/<int:restaurant_id>', views.get_restaurant_reviews),
    path('add-reservation', views.add_reservation),
    path('get-top-restaurant', views.get_top_restaurants),
]