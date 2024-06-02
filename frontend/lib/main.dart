import 'package:flutter/material.dart';
import 'package:frontend/screens/MyApp.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/manager_menu_informations.dart';
import 'package:frontend/screens/manager_venue_information.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/update-vanue',
    routes: {
      '/': (context) => const ManagerHome(),
      '/add-review': (context) => const AddReview(),
      '/profile': (context) => const Profile(),
      '/update-menu': (context) => const ManagerMenuInformations(),
      '/update-vanue': (context) => const ManagerVenueInformation(),
    },
  ));
}
