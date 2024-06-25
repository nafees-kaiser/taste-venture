import 'package:flutter/material.dart';
import 'package:frontend/widgets/menu_card.dart';

class RestaurantMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return MenuCard();
      },
      itemCount: 5,
    );
  }
}
