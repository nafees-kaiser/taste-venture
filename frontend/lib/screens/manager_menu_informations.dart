import 'package:flutter/material.dart';
import 'package:frontend/widgets/manager_menu_bottom_navigation.dart';
import 'package:frontend/widgets/manager_menu_card.dart';

class ManagerMenuInformations extends StatelessWidget {
  const ManagerMenuInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Menu information",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
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
      bottomNavigationBar: const ManagerMenuBottomNavigation(),
    );
  }
}
