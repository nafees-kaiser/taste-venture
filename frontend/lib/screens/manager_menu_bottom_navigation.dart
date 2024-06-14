import 'package:flutter/material.dart';
import 'package:frontend/widgets/manager_menu_informations.dart';
import 'package:frontend/widgets/manager_venue_information.dart';

class ManagerMenuBottomNavigation extends StatefulWidget {
  const ManagerMenuBottomNavigation({super.key});

  @override
  State<ManagerMenuBottomNavigation> createState() =>
      _ManagerMenuBottomNavigationState();
}

class _ManagerMenuBottomNavigationState
    extends State<ManagerMenuBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? const ManagerVenueInformation()
          : const ManagerMenuInformations(),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey[100],
        height: 70,
        indicatorColor: Colors.grey[100],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              size: 30,
              color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
            ),
            label: "Restaurant",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.list_alt,
              size: 30,
              color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
            ),
            label: "Menu",
          ),
        ],
      ),
    );
  }
}
