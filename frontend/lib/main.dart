import 'package:flutter/material.dart';
import 'package:frontend/screens/favorite.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';
import 'package:frontend/utils/scheme.dart';
import 'package:frontend/screens/manager_menu_bottom_navigation.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/favorite',
    theme: Scheme.lightTheme,
    themeMode: ThemeMode.system,
    routes: {
      '/': (context) => const ManagerHome(),
      '/add-review': (context) => const AddReview(),
      '/profile': (context) => const Profile(),
      '/edit-information': (context) => const ManagerMenuBottomNavigation(),
      '/login' : (context) => Login(),
      '/favorite' : (context) => const Favorite(),
    },
  ));
}
