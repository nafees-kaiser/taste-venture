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
            accountName: const Text("Shahabuddin"),
            accountEmail: const Text("shavoddin54@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/profile.png'),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
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
            onTap: () => print('edit information tapped'),
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
            onTap: () => print('logout tapped'),
          ),
        ],
      ),
    );
  }
}
