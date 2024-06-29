import 'package:flutter/material.dart';
import 'package:frontend/widgets/initial_menu_content.dart';

class InitialMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: InitialMenuContent(),
      ),
    );
  }
}

