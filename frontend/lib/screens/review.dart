// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class Reviews extends StatelessWidget {
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
    // Add more reviews as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   // color: Color(0xFFFF4778),
            //   padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       // Padding(
            //       // padding: const EdgeInsets.only(left: 3.0),
            //       SvgPicture.asset(
            //         'assets/vectors/vector_3_x2.svg',
            //         width: 20,
            //         height: 20,
            //       ),
            //       // ),
            //       SizedBox(width: 12),
            //       Expanded(
            //         child: Text(
            //           'Ratings and Reviews',
            //           textAlign: TextAlign.center,
            //           style: GoogleFonts.getFont('Inter',
            //               fontWeight: FontWeight.w500,
            //               fontSize: 25,
            //               letterSpacing: -0.2,
            //               color: Colors.black),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
            Container(
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
                              buildRatingRow(5, 0.9),
                              buildRatingRow(4, 0.7),
                              buildRatingRow(3, 0.5),
                              buildRatingRow(2, 0.2),
                              buildRatingRow(1, 0.1),
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
                              '4.0',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < 4
                                      ? Color.fromARGB(255, 161, 159, 47)
                                      : Color(0xFFC4C4C4),
                                  size: 16,
                                );
                              }),
                            ),
                          ),
                          Text(
                            '52 Reviews',
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY_COLOR),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/vector_34_x2.svg',
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            reviews[index]['user'],
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF000000),
                            ),
                          ),
                          Spacer(),
                          Text(
                            reviews[index]['date'],
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
                        children: List.generate(
                          reviews[index]['ratingStars'].length,
                          (starIndex) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: SvgPicture.asset(
                                'assets/vectors/star_${reviews[index]['ratingStars'][starIndex]}_x2.svg',
                                width: 16,
                                height: 16,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        reviews[index]['reviewText'],
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
