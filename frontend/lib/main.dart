import 'package:flutter/material.dart';
import 'package:frontend/screens/MyApp.dart';
import 'package:frontend/screens/Profile.dart';
import 'package:frontend/screens/add_review.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/add_review',
    routes: {
      '/': (context) => const Profile(),
      '/add_review': (context) => const AddReview(),
    },
  ));
}
