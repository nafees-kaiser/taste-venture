import 'package:flutter/material.dart';
import 'package:frontend/screens/MyApp.dart';
import 'package:frontend/screens/manager_home.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/add_review.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const ManagerHome(),
      '/add_review': (context) => const AddReview(),
      '/profile': (context) => const Profile(),
    },
  ));
}
