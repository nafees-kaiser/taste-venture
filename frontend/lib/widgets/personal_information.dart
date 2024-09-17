import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_information_card.dart';

class PersonalInformation extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const PersonalInformation({this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Profileinfocard(
          name: "Email",
          text: userData?['email'] ?? "Unknown",
          icon: Icons.email,
        ),
        Profileinfocard(
          name: "Name",
          text: userData?['name'] ?? "Unknown",
          icon: Icons.person,
        ),
        Profileinfocard(
          name: "Contact",
          text: userData?['contact'] ?? "Unknown",
          icon: Icons.call,
        ),
        Profileinfocard(
          name: "Date of Birth",
          text: userData?['dob'] ?? "Unknown",
          icon: Icons.calendar_month,
        ),
        Profileinfocard(
          name: "Gender",
          text: userData?['gender'] ?? "Unknown",
          icon: Icons.wc,
        ),
        Profileinfocard(
          name: "Address",
          text: userData?['address'] ?? "Unknown",
          icon: Icons.home,
        ),
      ],
    );
  }
}
