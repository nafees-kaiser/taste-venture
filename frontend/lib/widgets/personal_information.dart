import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_information_card.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
    );
  }
}
