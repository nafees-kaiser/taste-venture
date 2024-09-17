import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
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

  Future<Map<String, dynamic>> getData(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    ApiSettings api = ApiSettings(endPoint: '$url/$userId');
    try {
      final response = await api.getMethod();
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: getData('users/get-user'),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data!['name'],
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      accountEmail: Text(
                        snapshot.data!['email'],
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
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text("Account settings"),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text("Visiting History"),
                      onTap: () =>
                          Navigator.pushNamed(context, '/visiting-history'),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                );
              }
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
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () => Navigator.pushNamed(context, '/notification'),
          ),
          FutureBuilder<Map<String, dynamic>>(
              future: getData('users/get-user'),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove('userEmail');
                      await prefs.remove('token');
                      await prefs.remove('userType');
                      await prefs.remove('userId');
                      Navigator.pushNamed(context, '/login');
                    },
                  );
                } else {
                  return Container(
                    color: DISABLE,
                    child: ListTile(
                      leading: const Icon(Icons.login),
                      title: const Text("Login"),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('userEmail');
                        await prefs.remove('token');
                        await prefs.remove('userType');
                        await prefs.remove('userId');
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
