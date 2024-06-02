import 'package:flutter/material.dart';

class ManagerMenuBottomNavigation extends StatefulWidget {
  const ManagerMenuBottomNavigation({super.key});

  @override
  State<ManagerMenuBottomNavigation> createState() =>
      _ManagerMenuBottomNavigationState();
}

class _ManagerMenuBottomNavigationState
    extends State<ManagerMenuBottomNavigation> {
  final double customselectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: Colors.grey[100],
        height: 70,
        indicatorColor: Colors.grey[100],
        selectedIndex: 1,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              size: 30,
              color: customselectedIndex == 0 ? Colors.green : Colors.grey,
            ),
            label: "Restaurant",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.list_alt,
              size: 30,
              color: customselectedIndex == 1 ? Colors.green : Colors.grey,
            ),
            label: "menu",
          ),
        ]);
  }
}
