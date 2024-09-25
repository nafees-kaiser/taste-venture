import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class UserIndivisualReview extends StatefulWidget {
  final String userName, reviewText, date;
  final int rating;
  const UserIndivisualReview(
      {required this.userName,
      required this.reviewText,
      required this.rating,
      required this.date,
      super.key});

  @override
  State<UserIndivisualReview> createState() => _UserIndivisualReviewState();
}

class _UserIndivisualReviewState extends State<UserIndivisualReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: Theme.of(context).subSectionDividerPadding,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(3),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < (widget.rating?.round() ?? 0)
                                    ? Color.fromARGB(255, 161, 159, 47)
                                    : Color(0xFFC4C4C4),
                                size: 16,
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.date.toString().split('T')[0],
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10,
              ),
              child: Text(
                widget.reviewText,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
