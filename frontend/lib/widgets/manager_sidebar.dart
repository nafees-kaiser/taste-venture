import 'package:flutter/material.dart';

class ManagerSidebar extends StatelessWidget {
  const ManagerSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Shahabuddin",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            accountEmail: const Text(
              "shavoddin54@gmail.com",
              style: TextStyle(
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
            leading: const Icon(Icons.account_box),
            title: const Text("Account settings"),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Information"),
            onTap: () {
              Navigator.pushNamed(context, '/edit-information');
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("Reservations"),
            onTap: () => print('reservations tapped'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () => print('notification tapped'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
