import 'package:flutter/material.dart';
import 'package:frontend/pages/MyApp.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
    },
  ));
}
