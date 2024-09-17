import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSidebar extends StatefulWidget {
  const CustomerSidebar({super.key});

  @override
  State<CustomerSidebar> createState() => _CustomerSidebarState();
}

class _CustomerSidebarState extends State<CustomerSidebar> {
  late Future<String?> email;
  ApiSettings get_user_api = ApiSettings(endPoint: 'user/get-user');

  @override
  void initState() {
    super.initState();
    email = getInfo();
  }

  Future<String?> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<String?>(
            future: email,
            builder: (context, snapshot) {
              String email = snapshot.data ?? 'Email not found';
              return UserAccountsDrawerHeader(
                accountName: const Text(
                  "Shahabuddin",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                accountEmail: Text(
                  email,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('assets/profile.png'),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("Account settings"),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.pushNamed(context, '/favorite');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Visiting History"),
            onTap: () => Navigator.pushNamed(context, '/visiting-history'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () => Navigator.pushNamed(context, '/notification'),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text("Login"),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userEmail');
              await prefs.remove('token');
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
