import 'package:flutter/material.dart';
import 'package:frontend/widgets/customer_preferences.dart';

class CustomerPreferencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: CustomerPreferences(),
    );
  }
}


