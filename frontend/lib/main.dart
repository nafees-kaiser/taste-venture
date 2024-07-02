import 'package:flutter/material.dart';
import 'package:frontend/screens/customer_preferences.dart';
import 'package:frontend/screens/customer_homepage.dart';
import 'package:frontend/screens/favorite.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';
import 'package:frontend/screens/restaurant_info.dart';
import 'package:frontend/screens/registration_customer.dart';
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
    initialRoute: '/login',
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
      '/favorite': (context) => const Favorite(),
      '/add-restaurant': (context) => RegistrationVenueManager(),
      '/criteria': (context) => ManagerCriteria(),
      '/criteria1': (context) => ManagerCriteria1(),
      '/review': (context) => Reviews(),
      '/preference': (context) => CustomerPreferences(),
      '/booking': (context) => Booking(),
      '/restaurant-view': (context) => Restaurant(),
      '/tourspot-view': (context) => TourSpot(),
    },
  ));
}
