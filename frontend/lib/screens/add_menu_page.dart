import 'package:flutter/material.dart';
import 'package:frontend/widgets/add_menu_form.dart';

class AddMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: AddMenuForm(),
      ),
    );
  }
}


