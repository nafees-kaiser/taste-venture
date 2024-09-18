from django.urls import path

from tourspot import views

urlpatterns = [
    path('register-manager', views.add_manager, name='add_manager'),
    path('view-list', views.view_tourspot_list, name='view_tourspot_list'),
    path('view-list/<int:id>/', views.view_tourspot_detail, name='tourspot_detail'),
    path('add-booking', views.add_booking, name='add_booking'),
    path('accept-booking', views.accept_booking),
    path('reject-booking', views.reject_booking),
    path('view-booking/<int:user_id>', views.view_booking, name='view_booking'),
    path('add-daytour-review', views.add_dayTour_review, name='add-dayTour-review'),
    path('get-daytour-review/<int:tourSpot_id>', views.get_dayTour_reviews, name='get-daytour-review'),
    path('get-top-daytour', views.get_top_dayTourSpot, name='get-top-daytourspot'),
    path('view-pending-booking/<int:tourspot_id>', views.view_pending_booking, name='view_pending_booking'),
    path('view-booking-manager/<int:tourspot_id>', views.view_booking_manager, name='view_booking_manager')
]