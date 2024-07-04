// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manager_criteria.dart';

class ManagerCriteria1 extends StatefulWidget {
  @override
  _ManagerCriteriaState1 createState() => _ManagerCriteriaState1();
}

class _ManagerCriteriaState1 extends State<ManagerCriteria1> {
  final List<Map<String, String>> cuisines = [
    {
      'name': 'Healthy',
      'image': 'assets/rectangle_384.png',
    },
    {
      'name': 'Fast food',
      'image': 'assets/rectangle_38.png',
    },
    {
      'name': 'Sweet',
      'image': 'assets/rectangle_383.png',
    },
    {
      'name': 'Spicy',
      'image': 'assets/SpicyFood.png',
    },
    {
      'name': 'Sour',
      'image': 'assets/rectangle_389.png',
    },
    {
      'name': 'Savory',
      'image': 'assets/rectangle_382.png',
    },
  ];

  int currentPage = 2; // Current page indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criteria"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18),
            //   child: Text(
            //     'Criteria',
            //     style: GoogleFonts.getFont(
            //       'Inter',
            //       fontWeight: FontWeight.w500,
            //       fontSize: 28,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'What type of food you offer?',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 28,
                crossAxisSpacing: 24,
                childAspectRatio: (145.2 / 125), // width / (height + text)
              ),
              itemCount: cuisines.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Color(0xFFFAFAFA)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(cuisines[index]['image']!),
                        ),
                      ),
                      width: 145.2,
                      height: 100,
                    ),
                    SizedBox(height: 7),
                    Text(
                      cuisines[index]['name']!,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 24),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(currentPage == 1),
                    _buildDot(currentPage == 2),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildButton('Previous'),
                    SizedBox(width: 16),
                    _buildButton('Next'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFFFC5110) : Colors.grey,
      ),
    );
  }

  Widget _buildButton(String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Previous') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManagerCriteria()),
          );
        } else {
          Navigator.pushNamed(context, '/initial-menu');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFC5110),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
