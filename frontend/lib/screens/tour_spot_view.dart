// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TourSpot extends StatefulWidget {
  @override
  State<TourSpot> createState() => _TourSpotState();
}

class _TourSpotState extends State<TourSpot> {
  final List<Map<String, dynamic>> tourSpots = [
    {
      'imagePath': 'assets/image.jpeg',
      'name': 'Water Garden Resort & Spa',
      'location': 'Dinajpore, Karatia, Tangail',
      'rating': 4,
      'favorite': true,
    },
    {
      'imagePath': 'assets/image.jpeg',
      'name': 'Another Tour Spot',
      'location': 'Location XYZ',
      'rating': 4.5,
      'favorite': true,
    },
    {
      'imagePath': 'assets/image.jpeg',
      'name': 'Another Tour Spot',
      'location': 'Location XYZ',
      'rating': 4.5,
      'favorite': false,
    },
    // Add more tour spot data as needed
  ];

  void toggleFavorite(int i) {
    setState(() {
      tourSpots[i]['favorite'] = !tourSpots[i]['favorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 2, 2, 2),
            ),
            SizedBox(width: 8),
            Text(
              'Mirpur 12, Dhaka',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.2,
                color: Color.fromARGB(255, 2, 2, 2),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFFF9F9F9),
              padding: EdgeInsets.only(bottom: 16.7),
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    child: SearchBar(
                      elevation: const WidgetStatePropertyAll(1),
                      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
                      hintText: "Search",
                      hintStyle: const WidgetStatePropertyAll(TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                      leading: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Day-tour Spot',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      color: Color(0xFF222222),
                    ),
                  ),
                  SizedBox(height: 14),
                  Container(
                    color: Color(0xFFF9F9F9),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                              height: 12,
                              child: SvgPicture.asset(
                                  'assets/vectors/vector_31_x2.svg'),
                            ),
                            SizedBox(width: 11),
                            Text(
                              'Filters',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14,
                              height: 18,
                              child: SvgPicture.asset(
                                  'assets/vectors/vector_8_x2.svg'),
                            ),
                            SizedBox(width: 11),
                            Text(
                              'Sort by',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < tourSpots.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: 14),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    tourSpots[i]['imagePath'],
                                    fit: BoxFit.cover,
                                    height: 120,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 8, 6.7, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tourSpots[i]['name'],
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Color(0xFF222222),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Color.fromARGB(255, 2, 2, 2),
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              tourSpots[i]['location'],
                                              style: GoogleFonts.getFont(
                                                'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: Color(0xFF000000),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.1),
                                      Row(
                                        children: [
                                          for (int j = 0;
                                              j < tourSpots[i]['rating'];
                                              j++)
                                            SvgPicture.asset(
                                                'assets/vectors/star_5_x2.svg'),
                                          SizedBox(width: 4.5),
                                          Text(
                                            '(${tourSpots[i]['rating']})',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Color(0xFF9B9B9B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              child: tourSpots[i]['favorite']
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.pink,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                    ),
                              onTap: () => toggleFavorite(i),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}