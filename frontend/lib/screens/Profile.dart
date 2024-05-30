import 'package:flutter/material.dart';
import 'package:frontend/widgets/additional_information.dart';
import 'package:frontend/widgets/personal_information.dart';
import 'package:frontend/widgets/profile_perference.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int clickedItem = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 150,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "My \nProfile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 80), // Add some space at the top
                      const Text(
                        "Shahabuddin Akhon",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          height: 2,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    clickedItem = 1;
                                  });
                                },
                                child: Text(
                                  "Personal \nInformation",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: clickedItem == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    clickedItem = 2;
                                  });
                                },
                                child: Text(
                                  "Additional \nInformation",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: clickedItem == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    clickedItem = 3;
                                  });
                                },
                                child: Text(
                                  "Preference",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: clickedItem == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (clickedItem == 1)
                        const PersonalInformation()
                      else if (clickedItem == 2)
                        const AdditionalInformation()
                      else if (clickedItem == 3)
                        const ProfilePerference()
                    ],
                  ),
                ),
                Positioned(
                  top: -75,
                  left: MediaQuery.of(context).size.width / 2 -
                      70, // Center the image
                  child: Container(
                    width: 150,
                    height: 150, // Ensure the container is square
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the container circular
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color:
                            Colors.black, // Optional: specify the border color
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/profile.png",
                          fit: BoxFit
                              .cover, // Ensure the image covers the container
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
