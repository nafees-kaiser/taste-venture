import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_information_card.dart';

class ProfilePerference extends StatelessWidget {
  const ProfilePerference({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Profileinfocard(
          name: "Food Type",
          text: "Healthy",
          icon: Icons.recommend,
        ),
        Profileinfocard(
          name: "Preferred Cuisine",
          text: "Italian\nJapanese\nIndian",
          icon: Icons.restaurant,
        ),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}
