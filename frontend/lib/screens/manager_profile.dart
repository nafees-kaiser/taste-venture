import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_information_card.dart';

class ManagerProfile extends StatelessWidget {
  // const ManagerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Profileinfocard(
              name: "Email",
              text: "Shahabuddin@Akhon.com",
              icon: Icons.email,
            ),
            Profileinfocard(
              name: "Name",
              text: "Shahabuddin Akhon",
              icon: Icons.person,
            ),
            Profileinfocard(
              name: "Mobile",
              text: "+8801982711168",
              icon: Icons.call,
            ),
            Profileinfocard(
              name: "Date of Birth",
              text: "12/02/2001",
              icon: Icons.calendar_month,
            ),
            Profileinfocard(
              name: "Gender",
              text: "Male",
              icon: Icons.wc,
            ),
            Profileinfocard(
              name: "Address",
              text: "Jatrabari,Dhaka-1236",
              icon: Icons.home,
            ),
          ],
        ),
      ),
    );
  }
}
