import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/manager_menu_card.dart';

class ManagerMenuInformations extends StatelessWidget {
  const ManagerMenuInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu information",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Theme.of(context).largemainPadding,
          child: const Column(
            children: [
              ManagerMenuCard(
                image: "assets/pizza.jpg",
                heading: "Chicken Fajita Pizza",
                description: "8\" pizza with regular soft drink",
                price: "\$15",
              ),
              ManagerMenuCard(
                image: "assets/pizza.jpg",
                heading: "Chicken Fajita Pizza",
                description: "8\" pizza with regular soft drink",
                price: "\$15",
              ),
              ManagerMenuCard(
                image: "assets/pizza.jpg",
                heading: "Chicken Fajita Pizza",
                description: "8\" pizza with regular soft drink",
                price: "\$15",
              ),
              ManagerMenuCard(
                image: "assets/pizza.jpg",
                heading: "Chicken Fajita Pizza",
                description: "8\" pizza with regular soft drink",
                price: "\$15",
              ),
              ManagerMenuCard(
                image: "assets/pizza.jpg",
                heading: "Chicken Fajita Pizza",
                description: "8\" pizza with regular soft drink",
                price: "\$15",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
