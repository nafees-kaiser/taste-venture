// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/screens/tour_spot_details_page.dart';
import 'package:frontend/utils/build_image_file.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/customer_sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:number_paginator/number_paginator.dart';

class TourSpot extends StatefulWidget {
  @override
  State<TourSpot> createState() => _TourSpotState();
}

class _TourSpotState extends State<TourSpot> {
  int numberOfPages = 10;
  int currentPage = 1;
  List<Map<String, dynamic>> tourSpots = [];

  String sortBy; // Default sorting option
  String sortOrder = 'asc'; // Default sort order
  final TextEditingController searchController = TextEditingController();
  String dropdownValue = 'Rating low-to-high';

  @override
  void initState() {
    super.initState();
    fetchTourSpots();
  }

  Future<void> fetchTourSpots() async {
    ApiSettings api = ApiSettings(
        endPoint:
            'tourspot/view-list?page=$currentPage&search=${searchController.text}&sort_by=$sortBy&sort_order=$sortOrder');
    final response = await api.getMethod();

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      List<dynamic> tourspotsData = data["results"]["results"];
      print(data);
      setState(() {
        tourSpots =
            tourspotsData.map((item) => item as Map<String, dynamic>).toList();
        numberOfPages = (data["count"] / data["results"]["page_size"]).ceil();
        // print(numberOfPages);
      });
      // List<dynamic> data = jsonDecode(response.body);
      // print(data);
      // setState(() {
      //   tourSpots = data.map((item) => item as Map<String, dynamic>).toList();
      // });
    } else {
      // Handle the error
      throw Exception('Failed to load tour spots');
    }
  }

  void toggleFavorite(int i) {
    setState(() {
      tourSpots[i]['favorite'] = !tourSpots[i]['favorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomerSidebar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        title:
            // Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // children: [
            // Icon(
            //   Icons.location_on,
            //   color: Color.fromARGB(255, 2, 2, 2),
            // ),
            // SizedBox(width: 8),
            Text(
          // 'Mirpur 12, Dhaka',
          "TasteVenture",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: -0.2,
            color: Color.fromARGB(255, 2, 2, 2),
          ),
        ),
        // ],
        // ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications),
        //     onPressed: () => Navigator.pushNamed(context, '/notification'),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFFF9F9F9),
              // child: Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: searchController,
              //           decoration: InputDecoration(
              //             hintText: 'Search',
              //             hintStyle: TextStyle(color: Colors.grey),
              //             border: OutlineInputBorder(),
              //           ),
              //           onSubmitted: (value) {
              //             fetchTourSpots(); // Fetch data on search
              //           },
              //         ),
              //       ),
              //       DropdownButton<String>(
              //         value: sortOrder, // The current selected value
              //         icon: const Icon(Icons.arrow_drop_down),
              //         items: <String>['asc', 'desc']
              //             .map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value.toUpperCase()),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             sortOrder = newValue!;
              //             fetchTourSpots(); // Fetch data with new sort order
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              padding: EdgeInsets.only(bottom: 16.7),
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    child: SearchBar(
                      controller: searchController,
                      elevation: const WidgetStatePropertyAll(1),
                      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
                      hintText: "Search",
                      hintStyle: const WidgetStatePropertyAll(TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                      onSubmitted: (value) {
                        fetchTourSpots(); // Fetch data on search
                      },
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
                    padding: EdgeInsets.fromLTRB(12, 8, 25, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 18,
                        //       height: 12,
                        //       child: SvgPicture.asset(
                        //           'assets/vectors/vector_31_x2.svg'),
                        //     ),
                        //     SizedBox(width: 11),
                        //     Text(
                        //       'Filters',
                        //       style: GoogleFonts.inter(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 11,
                        //         color: Color(0xFF222222),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14,
                              height: 18,
                              child: SvgPicture.asset(
                                  'assets/vectors/vector_8_x2.svg'),
                            ),
                            SizedBox(width: 11),
                            // "Sort by" label
                            Text(
                              'Sort by:',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xFF222222),
                              ),
                            ),
                            SizedBox(
                                width: 10), // Space between text and dropdown
                            // Dropdown menu
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xFF222222), size: 14),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color(0xFF222222),
                              ),
                              underline: Container(
                                height: 0, // Hide the default underline
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  // Map dropdown options to sort order values
                                  sortOrder =
                                      dropdownValue == 'Rating low-to-high'
                                          ? 'asc'
                                          : 'desc';
                                  sortBy = 'average_rating';
                                  // Fetch sorted tour spots
                                  fetchTourSpots();
                                });
                              },
                              // Dropdown options
                              items: <String>[
                                'Rating low-to-high',
                                'Rating high-to-low'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 14,
                        //       height: 18,
                        //       child: SvgPicture.asset(
                        //           'assets/vectors/vector_8_x2.svg'),
                        //     ),
                        //     SizedBox(width: 11),
                        //     DropdownButton<String>(
                        //       value: dropdownValue,
                        //       icon: Icon(Icons.arrow_drop_down,
                        //           color: Color(0xFF222222), size: 14),
                        //       style: GoogleFonts.inter(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 11,
                        //         color: Color(0xFF222222),
                        //       ),
                        //       underline: Container(
                        //         height: 0, // Hide the default underline
                        //       ),
                        //       onChanged: (String? newValue) {
                        //         setState(() {
                        //           dropdownValue = newValue!;
                        //           sortOrder = dropdownValue == 'Ascending'
                        //               ? 'asc'
                        //               : 'desc';
                        //           fetchTourSpots();
                        //         });
                        //       },
                        //       items: <String>[
                        //         'Rating low-to-high',
                        //         'Rating high-to-low'
                        //       ].map<DropdownMenuItem<String>>((String value) {
                        //         return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Text(value),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ],
                        // ),

                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 14,
                        //       height: 18,
                        //       child: SvgPicture.asset(
                        //           'assets/vectors/vector_8_x2.svg'),
                        //     ),
                        //     SizedBox(width: 11),
                        //     Text(
                        //       'Sort by',
                        //       style: GoogleFonts.inter(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 11,
                        //         color: Color(0xFF222222),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TourSpotDetailsPage(
                            id: tourSpots[i]['id'],
                          ),
                        ),
                      ),
                      // Navigator.pushNamed(
                      //   context,
                      //   '/tourspot-detail',
                      //   arguments: tourSpots[i],
                      // ),
                      child: Container(
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
                                    child: tourSpots[i]['image'] == null
                                        ? const Image(
                                            image: AssetImage(
                                                'assets/image_filler.png'),
                                            fit: BoxFit.cover,
                                            height: 120,
                                          )
                                        : Image.network(
                                            // ApiSettings(
                                            //         endPoint: urlModify(tourSpots[i]
                                            //             ['image']))
                                            //     .getUri(),
                                            tourSpots[i]['image'],
                                            fit: BoxFit.cover,
                                            height: 120,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Image(
                                              image: AssetImage(
                                                  'assets/image_filler.png'),
                                              fit: BoxFit.cover,
                                              height: 120,
                                            ),
                                          ),

                                    // Image.asset(
                                    //   'assets/image.jpeg',
                                    //   // tourSpots[i]['imagePath'],
                                    //   fit: BoxFit.cover,
                                    //   height: 120,
                                    // ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 8, 6.7, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tourSpots[i]['tourspot_name'],
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
                                              color:
                                                  Color.fromARGB(255, 2, 2, 2),
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                tourSpots[i]['address'],
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
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  8, 8, 8, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    List.generate(5, (index) {
                                                  return Icon(
                                                    Icons.star,
                                                    color: index <
                                                            (tourSpots[i][
                                                                        'average_rating']
                                                                    ?.round() ??
                                                                0)
                                                        ? Color.fromARGB(
                                                            255, 161, 159, 47)
                                                        : Color(0xFFC4C4C4),
                                                    size: 16,
                                                  );
                                                }),
                                              ),
                                            ),

                                            // for (int j = 0;j < tourSpots[i]['rating'];j++)
                                            // for (int j = 0; j < 5; j++)
                                            // SvgPicture.asset(
                                            //     'assets/vectors/star_5_x2.svg'),
                                            SizedBox(width: 4.5),
                                            Text(
                                              '(${tourSpots[i]['average_rating']})',
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
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: GestureDetector(
                            //     // child: tourSpots[i]['favorite']
                            //     child: true
                            //         ? Icon(
                            //             Icons.favorite,
                            //             color: Colors.pink,
                            //           )
                            //         : Icon(
                            //             Icons.favorite_border,
                            //           ),
                            //     onTap: () => toggleFavorite(i),
                            //   ),
                            // ),
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
                    buttonSelectedBackgroundColor: SECONDARY_COLOR,
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
                  fetchTourSpots();
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
