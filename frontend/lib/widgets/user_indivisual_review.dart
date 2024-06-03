import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:frontend/utils/custom_theme.dart';

class UserIndivisualReview extends StatefulWidget {
  const UserIndivisualReview({super.key});

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
                        "assets/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shahabuddin akhon",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Row(
                      children: [
                        RatingStars(
                          axis: Axis.horizontal,
                          value: 4,
                          starCount: 5,
                          starSize: 20,
                          maxValue: 5,
                          starSpacing: 2,
                          maxValueVisibility: false,
                          valueLabelVisibility: false,
                          starOffColor: Color(0xffe7e8ea),
                          starColor: Color.fromARGB(255, 209, 193, 51),
                          angle: 12,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("2 min ago"),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10,
              ),
              child: Text(
                "La Bella Italia has always been one of my favorite spots, but this recent visit truly solidified its place in my heart. I decided to try their Margherita Pizza, a classic staple that can often be a litmus test for the quality of an Italian restaurant.",
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
