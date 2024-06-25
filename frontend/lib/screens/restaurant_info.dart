import 'package:flutter/material.dart';
import 'package:frontend/screens/restaurant_detail.dart';
import 'package:frontend/screens/restaurant_menu_view.dart';

class RestaurantInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Information"),
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: RestaurantMenuView(),
    );
  }
  
}