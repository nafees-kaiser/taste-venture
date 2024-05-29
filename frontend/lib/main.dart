import 'package:flutter/material.dart';
import 'package:frontend/pages/MyApp.dart';
import 'package:frontend/pages/Profile.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Profile(),
    },
  ));
}
