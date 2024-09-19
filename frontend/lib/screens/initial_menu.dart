import 'package:flutter/material.dart';
import 'package:frontend/models/restaurant.dart';
import 'package:frontend/widgets/initial_menu_content.dart';
import 'package:image_input/image_input.dart';

class InitialMenu extends StatelessWidget {
  final RestaurantModel? restaurantModel;
  final XFile? itemImage;
  const InitialMenu({
    super.key,
    this.restaurantModel,
    this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: InitialMenuContent(
          restaurantModel: restaurantModel,
          itemImage: itemImage,
        ),
      ),
    );
  }
}
