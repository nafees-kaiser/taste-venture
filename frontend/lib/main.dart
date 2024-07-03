import 'package:flutter/material.dart';
import 'package:frontend/screens/add_menu_page.dart';
import 'package:frontend/screens/customer_preferences_page.dart';
import 'package:frontend/screens/customer_homepage.dart';
import 'package:frontend/screens/customer_reservation.dart';
import 'package:frontend/screens/favorite.dart';
import 'package:frontend/screens/forget_password.dart';
import 'package:frontend/screens/initial_menu.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/notification_page.dart';
import 'package:frontend/screens/otp_page.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';
import 'package:frontend/screens/reservation_list.dart';
import 'package:frontend/screens/reset_password.dart';
import 'package:frontend/screens/reservation_manager.dart';
import 'package:frontend/screens/restaurant_info.dart';
import 'package:frontend/screens/registration_customer.dart';
import 'package:frontend/screens/tour_spot_details_page.dart';
import 'package:frontend/screens/visiting_history_page.dart';
import 'package:frontend/utils/scheme.dart';
import 'package:frontend/screens/manager_menu_bottom_navigation.dart';
import 'package:frontend/screens/registration_manager.dart';
import 'package:frontend/screens/manager_criteria.dart';
import 'package:frontend/screens/manager_criteria_1.dart';
import 'package:frontend/screens/review.dart';
import 'package:frontend/screens/booking.dart';
import 'package:frontend/screens/restaurants.dart';
import 'package:frontend/screens/tour_spot_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/customer/reservation',
    theme: Scheme.lightTheme,
    themeMode: ThemeMode.system,
    routes: {
      '/manager-home': (context) => const ManagerHome(),
      // '/': (context) => const ManagerHome(),
      '/customer-homepage': (context) => const CustomerHomepage(),
      '/add-review': (context) => const AddReview(),
      '/profile': (context) => const Profile(),
      '/edit-information': (context) => const ManagerMenuBottomNavigation(),
      '/registration/customer': (context) => const RegistrationCustomer(),
      '/login': (context) => Login(),
      '/restaurant/information': (context) => RestaurantInfo(),
      '/favorite': (context) => Favorite(),
      '/add-restaurant': (context) => RegistrationVenueManager(),
      '/criteria': (context) => ManagerCriteria(),
      '/criteria1': (context) => ManagerCriteria1(),
      '/review': (context) => Reviews(),
      '/preference': (context) => CustomerPreferencePage(),
      '/booking': (context) => Booking(),
      '/restaurant-view': (context) => Restaurant(),
      '/tourspot-view': (context) => TourSpot(),
      '/notification': (context) => NotificationPage(),
      '/visiting-history': (contex) => VisitingHistoryPage(),
      '/add-menu': (context) => AddMenuPage(),
      '/initial-menu': (context) => InitialMenu(),
      '/forget-password': (context) => ForgetPassword(),
      '/otp-page': (context) => OtpPage(),
      '/reset-pass': (context) => ResetPassword(),
      '/restaurant/reservation-manager': (context) => ReservationManager(),
      '/restaurant/reservation-list': (context) => ReservationList(),
      '/tourspot-detail' : (context) => TourSpotDetailsPage(),
      '/customer/reservation' : (context) => CustomerReservation(),
    },
  ));
}
