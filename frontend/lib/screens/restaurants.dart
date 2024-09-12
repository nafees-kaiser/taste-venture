// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/view_restaurant_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_paginator/number_paginator.dart';

class Restaurant extends StatefulWidget {
  final bool isPersonalizedView;

  Restaurant({this.isPersonalizedView = false});

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  int numberOfPages = 10;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  List<Map<String, dynamic>> restaurants = [
    // {
    //   'imagePath': 'assets/image.jpeg',
    //   'name': 'Chefs Table',
    //   'address': 'Gulshan 2, Dhaka',
    //   'rating': 4,
    //   'favorite': true,
    // },
    // {
    //   'imagePath': 'assets/image.jpeg',
    //   'name': 'Another Restaurant',
    //   'address': 'Location XYZ',
    //   'rating': 4.5,
    //   'favorite': true,
    // },
    // {
    //   'imagePath': 'assets/image.jpeg',
    //   'name': 'Another Restaurant',
    //   'address: 'Location XYZ',
    //   'rating': 4.5,
    //   'favorite': false,
    // },
    // // Add more tour spot data as needed
  ];

  Future<void> fetchRestaurants() async {
    ApiSettings api =
        ApiSettings(endPoint: 'restaurant/view-restaurant?page=$currentPage');
    final response = await api.getMethod();

    try {
      if (response.statusCode == 200) {
        //List<dynamic> data = jsonDecode(response.body);
        dynamic data = jsonDecode(response.body);
        List<dynamic> restaurantsData = data["results"];
        // print(data);
        setState(() {
          restaurants = restaurantsData
              .map((item) => item as Map<String, dynamic>)
              .toList();
          numberOfPages = (data["count"] / data["page_size"]).ceil();
          // print(numberOfPages);
        });
      } else {
        // Handle the error
        throw Exception('Failed to load Restaurants');
      }
    } catch (e) {
      throw Exception(e);
    }
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
            onPressed: () => Navigator.pushNamed(context, '/notification'),
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
                  if (!widget.isPersonalizedView)
                    Container(
                      width: 350,
                      height: 50,
                      child: SearchBar(
                        elevation: const WidgetStatePropertyAll(1),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey[300]),
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
                    'Restaurants',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      color: Color(0xFF222222),
                    ),
                  ),
                  if (!widget.isPersonalizedView)
                    Column(
                      children: [
                        SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Restaurant(isPersonalizedView: true),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'See Personalized Suggestion',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < restaurants.length; i++)
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/restaurant/information',
                        arguments: restaurants[i],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 14),
                        child: Stack(
                          children: [
                            ViewRestaurantCard(restaurants: restaurants, i: i),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: NumberPaginator(
                initialPage: 0,
                numberPages: numberOfPages,
                config: const NumberPaginatorUIConfig(
                    buttonSelectedBackgroundColor: PRIMARY_COLOR,
                    buttonUnselectedForegroundColor: TEXT),
                onPageChange: (index) async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      });

                  setState(() {
                    currentPage = index + 1;
                  });
                  fetchRestaurants();
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
