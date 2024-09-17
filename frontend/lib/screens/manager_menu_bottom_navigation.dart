import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ManagerVenueInformation(),
    );
  }
}
