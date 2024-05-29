import 'package:flutter/material.dart';
import 'package:frontend/widgets/ProfileinfoCard.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                              const Text(
                                "Personal \nInformation",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text(
                                "Additional \nInformation",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Text(
                                "Preference",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Profileinfocard(
                        name: "Email",
                        text: "Shahabuddin@Akhon.com",
                        icon: Icons.email,
                      ),
                      const Profileinfocard(
                        name: "Name",
                        text: "Shahabuddin Akhon",
                        icon: Icons.person,
                      ),
                      const Profileinfocard(
                        name: "Mobile",
                        text: "+8801982711168",
                        icon: Icons.call,
                      ),
                      const Profileinfocard(
                        name: "Date of Birth",
                        text: "12/02/2001",
                        icon: Icons.calendar_month,
                      ),
                      const Profileinfocard(
                        name: "Gender",
                        text: "Male",
                        icon: Icons.wc,
                      ),
                      const Profileinfocard(
                        name: "Address",
                        text: "Jatrabari,Dhaka-1236",
                        icon: Icons.home,
                      ),
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
