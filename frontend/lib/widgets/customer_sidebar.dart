import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSidebar extends StatefulWidget {
  const CustomerSidebar({Key? key}) : super(key: key);

  @override
  State<CustomerSidebar> createState() => _CustomerSidebarState();
}

class _CustomerSidebarState extends State<CustomerSidebar> {
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Guest';
      _userEmail = prefs.getString(
          'userEmail'); // No default, if null we show limited options
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: _userEmail == null
            ? _buildGuestSidebar() // Show limited options for guest
            : _buildUserSidebar(), // Show full options for logged-in user
      ),
    );
  }

  // Sidebar options for logged-in users
  List<Widget> _buildUserSidebar() {
    return [
      UserAccountsDrawerHeader(
        accountName: Text(''),
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
        onTap: () => Navigator.pushNamed(context, '/customer-homepage'),
      ),
      ListTile(
        leading: const Icon(Icons.account_circle),
        title: const Text("Account settings"),
        onTap: () => Navigator.pushNamed(context, '/profile'),
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text("Notifications"),
        onTap: () => Navigator.pushNamed(context, '/notification'),
      ),
      ListTile(
        leading: const Icon(Icons.history),
        title: const Text("Visiting History"),
        onTap: () => Navigator.pushNamed(context, '/visiting-history'),
      ),
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text("Favorites"),
        onTap: () => Navigator.pushNamed(context, '/favorite'),
      ),
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

  // Sidebar options for guest users (no email)
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
        onTap: () => Navigator.pushNamed(context, '/customer-homepage'),
      ),
      ListTile(
        leading: const Icon(Icons.login),
        title: const Text("Login"),
        onTap: () => Navigator.pushNamed(context, '/login'),
      ),
    ];
  }
}
