// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reviews extends StatefulWidget {
  final int id;
  final bool is_restaurant;
  const Reviews({required this.id, required this.is_restaurant, super.key});
  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final List<Map<String, dynamic>> reviews = [
    {
      'user': 'Shahabuddin Akhon',
      'date': '05/11/2024',
      'ratingStars': [5, 5, 5, 5, 5],
      'reviewText':
          'I recently had the pleasure of dining at Fusion Delights, and it was an unforgettable experience from start to finish. The restaurant seamlessly blends Italian and Japanese cuisines, creating a unique and delightful menu.',
    },
    {
      'user': 'John Doe',
      'date': '06/15/2024',
      'ratingStars': [5, 5, 5, 5, 5], // Assuming all 5 stars
      'reviewText':
          'Absolutely loved the food at Fusion Delights! The flavors were amazing and the service was exceptional. Highly recommend!',
    },
    {
      'user': 'John Doe',
      'date': '06/15/2024',
      'ratingStars': [5, 5, 5, 5, 5], // Assuming all 5 stars
      'reviewText':
          'Absolutely loved the food at Fusion Delights! The flavors were amazing and the service was exceptional. Highly recommend!',
    },
    {
      'user': 'John Doe',
      'date': '06/15/2024',
      'ratingStars': [5, 5, 5, 5, 5], // Assuming all 5 stars
      'reviewText':
          'Absolutely loved the food at Fusion Delights! The flavors were amazing and the service was exceptional. Highly recommend!',
    },
    // Add more reviews as needed
  ];

  Future<Map<String, dynamic>> getData() async {
    String url;
    if (widget.is_restaurant) {
      url = 'restaurant/get-restaurant-reviews';
    } else {
      url = 'tourspot/get-daytour-review';
    }
    ApiSettings api = ApiSettings(endPoint: '$url/${widget.id}');
    try {
      final response = await api.getMethod();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData);
        return responseData;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.is_restaurant
          ? AppBar(
              title: const Text("Reviews & Ratings"),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Text(
                'Rating',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: -0.2,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading data"));
                } else if (snapshot.hasData) {
                  // Extract data from snapshot
                  final data = snapshot.data!;
                  final averageRating = data['avg_rating'];
                  final totalReviews = data['total_reviews'];
                  final rating = data['ratings'];
                  int totalReviewsnumber =
                      rating.values.reduce((a, b) => a + b);
                  double normalizeRating(int count, int total) {
                    return total == 0 ? 0 : count / total;
                  }

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 9, 19),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8.6, 12, 8, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildRatingRow(
                                        5,
                                        normalizeRating(rating['5'] ?? 0,
                                            totalReviewsnumber)),
                                    buildRatingRow(
                                        4,
                                        normalizeRating(rating['4'] ?? 0,
                                            totalReviewsnumber)),
                                    buildRatingRow(
                                        3,
                                        normalizeRating(rating['3'] ?? 0,
                                            totalReviewsnumber)),
                                    buildRatingRow(
                                        2,
                                        normalizeRating(rating['2'] ?? 0,
                                            totalReviewsnumber)),
                                    buildRatingRow(
                                        1,
                                        normalizeRating(rating['1'] ?? 0,
                                            totalReviewsnumber)),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: Text(
                                    averageRating?.toStringAsFixed(1) ?? '0',
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                      letterSpacing: -0.4,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: index <
                                                (averageRating?.round() ?? 0)
                                            ? Color.fromARGB(255, 161, 159, 47)
                                            : Color(0xFFC4C4C4),
                                        size: 16,
                                      );
                                    }),
                                  ),
                                ),
                                Text(
                                  '${totalReviews ?? '0'} Reviews',
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: -0.1,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Reviews',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: -0.2,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  final reviews = data['reviews'];

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  review['user']['name'],
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  review['date'].toString().split('T')[0],
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    starIndex < review['rating']
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Color.fromARGB(255, 161, 159, 47),
                                    size: 16,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 8),
                            Text(
                              review['review'],
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                height: 1.4,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text('No reviews found'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Row buildRatingRow(int starCount, double barWidthFraction) {
    return Row(
      children: [
        Text(
          '$starCount',
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: -0.1,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(width: 4),
        SvgPicture.asset(
          'assets/vectors/star_13_x2.svg',
          width: 16,
          height: 16,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: barWidthFraction,
              child: Container(
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
