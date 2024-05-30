import 'package:flutter/material.dart';
import 'package:frontend/screens/MyApp.dart';
import 'package:frontend/screens/Profile.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Profile(),
    },
  ));
}
