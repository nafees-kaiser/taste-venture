import 'package:flutter/material.dart';
import 'package:frontend/screens/MyApp.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/manager_menu_informations.dart';
import 'package:frontend/screens/manager_venue_information.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';
import 'package:frontend/utils/scheme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    theme: Scheme.lightTheme,
    themeMode: ThemeMode.system,
    routes: {
      '/': (context) => const ManagerHome(),
      '/add-review': (context) => const AddReview(),
      '/profile': (context) => const Profile(),
      '/update-menu': (context) => const ManagerMenuInformations(),
      '/update-venue': (context) => const ManagerVenueInformation(),
    },
  ));
}
