import 'package:flutter/material.dart';
import 'package:frontend/screens/restaurant_detail.dart';
import 'package:frontend/screens/restaurant_menu_view.dart';
import 'package:frontend/screens/review.dart';

class RestaurantInfo extends StatefulWidget {
  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {

  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Information"),
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: switch (page) {
        1 => RestaurantMenuView(),
        2 => Reviews(),
        _ => RestaurantDetail()
      },
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text('Detail'),
              onTap: ()=> setState(() {
                page = 0;
              }),
            ),
            GestureDetector(
              child: Text('Menu'),
              onTap: ()=> setState(() {
                page = 1;
              }),
            ),
            GestureDetector(
              child: Text('Reviews'),
              onTap: ()=> setState(() {
                page = 2;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
