// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manager_criteria_1.dart';

class ManagerCriteria extends StatefulWidget {
  @override
  _ManagerCriteriaState createState() => _ManagerCriteriaState();
}

class _ManagerCriteriaState extends State<ManagerCriteria> {
  final List<Map<String, String>> cuisines = [
    {
      'name': 'French',
      'image': 'assets/rectangle_387.jpeg',
    },
    {
      'name': 'Italian',
      'image': 'assets/rectangle_385.jpeg',
    },
    {
      'name': 'Japanese',
      'image': 'assets/rectangle_388.jpeg',
    },
    {
      'name': 'Indian',
      'image': 'assets/rectangle_3811.jpeg',
    },
    {
      'name': 'Korean',
      'image': 'assets/rectangle_381.jpeg',
    },
    {
      'name': 'Chinese',
      'image': 'assets/rectangle_386.jpeg',
    },
    {
      'name': 'Western',
      'image': 'assets/rectangle_3813.jpeg',
    },
    {
      'name': 'Vietnamese',
      'image': 'assets/rectangle_3812.jpeg',
    },
  ];

  int currentPage = 1; // Current page indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criteria"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  'What cuisines you offer?',
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
                      _buildDot(currentPage == 1), // First page indicator
                      _buildDot(currentPage == 2), // Second page indicator
                    ],
                  ),
                  SizedBox(height: 15), // Space between dots and buttons
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
        if (title == 'Next') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManagerCriteria1()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: title == 'Previous' ? Color(0xFF959595) : Color(0xFFFC5110),
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
