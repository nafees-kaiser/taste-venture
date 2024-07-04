import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Text(
                  "MAIN DISHES",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Text(
                  "APPETIZERS",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: PRIMARY_COLOR,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
