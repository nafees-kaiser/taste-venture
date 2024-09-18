from django.urls import path

from restaurant import views

urlpatterns = [
    path('add-menu', views.add_menu),
    path('edit-menu', views.edit_menu),
    path('view-menu', views.view_menu, name='view_menu'),
    path('add-restaurant', views.add_restaurant),
    path('view-restaurant', views.view_restaurant),
    path('add-restaurant-review', views.add_restaurant_review),
    path('<int:restaurant_id>/', views.restaurant_details, name='restaurant_details'),
    path('edit-restaurant/<int:restaurant_id>/', views.edit_restaurant, name='edit_restaurant'),
    path('get-restaurant-reviews/<int:restaurant_id>', views.get_restaurant_reviews),
    path('add-reservation', views.add_reservation),
    path('view-pending-reservation/<int:restaurant_id>', views.view_pending_reservation),
    path('accept-reservation', views.accept_reservation),
    path('reject-reservation', views.reject_reservation),
    path('visiting-history/<int:user_id>', views.visiting_history, name='visiting_history'),
    path('get-restaurant-reservation', views.get_reservation_details, name='get_reservation_details'),
    path('get-top-restaurant', views.get_top_restaurants),
]