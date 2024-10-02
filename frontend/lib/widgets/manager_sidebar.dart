import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerSidebar extends StatefulWidget {
  const ManagerSidebar({super.key});

  @override
  State<ManagerSidebar> createState() => _ManagerSidebarState();
}

class _ManagerSidebarState extends State<ManagerSidebar> {
  String? _userName;
  String? _userEmail;
  String? _userType;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName');
      _userEmail = prefs.getString('userEmail');
      _userType = prefs.getString('userType');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children:
            _userEmail == null ? _buildGuestSidebar() : _buildManagerSidebar(),
      ),
    );
  }

  // Sidebar options for logged-in managers
  List<Widget> _buildManagerSidebar() {
    return [
      UserAccountsDrawerHeader(
        accountName: Text(
          _userName ?? '',
        ),
        accountEmail: Text(
          _userEmail ?? '',
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        currentAccountPicture: CircleAvatar(
          child: ClipOval(
            child: Image.asset('assets/avatar.jpg'),
          ),
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("Home"),
        onTap: () => Navigator.pushNamed(context, '/manager-home',
            arguments: {'userType': _userType}),
      ),
      if (_userType == 'tour_manager') ...[
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Venue Information"),
          onTap: () => Navigator.pushNamed(
              context, '/manager/tour-spot/venue-information'),
        ),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text("Booking"),
          onTap: () => Navigator.pushNamed(context, '/tourspot/booking-list'),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text("Booking History"),
          onTap: () =>
              Navigator.pushNamed(context, '/tourspot/booking-history'),
        )
      ] else if (_userType == 'res_manager') ...[
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Restaurant Information"),
          onTap: () => Navigator.pushNamed(
              context, '/manager/restaurant/restaurant-information'),
        ),
        ListTile(
          leading: const Icon(Icons.food_bank),
          title: const Text("Menu Information"),
          onTap: () => Navigator.pushNamed(
              context, '/manager/restaurant/menu-information'),
        ),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text("Reservations"),
          onTap: () =>
              Navigator.pushNamed(context, '/restaurant/reservation-manager'),
        ),
      ],
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Logout"),
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Navigator.pushNamed(context, '/login');
        },
      ),
    ];
  }

  // Sidebar options for guests (no email)
  List<Widget> _buildGuestSidebar() {
    return [
      const SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              'assets/logo.png',
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("Home"),
        onTap: () => Navigator.pushNamed(context, '/manager-home',
            arguments: 'tour_manager'),
      ),
      ListTile(
        leading: const Icon(Icons.login),
        title: const Text("Login"),
        onTap: () => Navigator.pushNamed(context, '/login'),
      ),
    ];
  }
}
