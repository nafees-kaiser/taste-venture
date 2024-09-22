import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerSidebar extends StatefulWidget {
  const ManagerSidebar({super.key});

  @override
  State<ManagerSidebar> createState() => _ManagerSidebarState();
}

class _ManagerSidebarState extends State<ManagerSidebar> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getData(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('userEmail');
    ApiSettings api = ApiSettings(endPoint: '$url');
    Map<String, dynamic> data = {
      "email": email,
    };
    try {
      final response = await api.postMethod(json.encode(data));
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
            future: getData('users/get-manager-info'),
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
                          child: Image.asset('assets/avatar.jpg'),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    // ListTile(
                    //   leading: const Icon(Icons.account_circle),
                    //   title: const Text("Account settings"),
                    //   onTap: () {
                    //     Navigator.pushNamed(context, '/manager-profile');
                    //   },
                    // ),
                    if (snapshot.data!['user_type'] == 'tour_manager')
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text("Venue Information"),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/manager/tour-spot/venue-information');
                        },
                      ),
                    if (snapshot.data!['user_type'] == 'res_manager')
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text("Restaurant Information"),
                        onTap: () {
                          Navigator.pushNamed(context,
                              '/manager/restaurant/restaurant-information');
                        },
                      ),
                    if (snapshot.data!['user_type'] == 'res_manager')
                      ListTile(
                        leading: const Icon(Icons.food_bank),
                        title: const Text("Menu Information"),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/manager/restaurant/menu-information');
                        },
                      ),
                    if (snapshot.data!['user_type'] == 'res_manager')
                      ListTile(
                        leading: const Icon(Icons.book_online),
                        title: const Text("Reservations"),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/restaurant/reservation-manager');
                          // print('reservations tapped'),
                        },
                      )
                    else
                      ListTile(
                        leading: const Icon(Icons.book_online),
                        title: const Text("Booking"),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/tourspot/booking-list');
                        },
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
