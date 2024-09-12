import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/widgets/add_menu_form.dart';

class AddMenuPage extends StatelessWidget {
  final String endPoint;
  final Function? addMenuItems;
  final bool isAddRestaurant;

  const AddMenuPage(
      {super.key,
      this.endPoint='/restaurant/add-menu',
      this.addMenuItems,
      this.isAddRestaurant = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: AddMenuForm(
          endPoint: endPoint,
          addMenuItems: addMenuItems,
          isAddRestaurant: isAddRestaurant,
        ),
      ),
    );
  }
}
