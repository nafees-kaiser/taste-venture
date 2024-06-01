import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:frontend/widgets/rating_progress_bar.dart';

class ReviewOverview extends StatelessWidget {
  const ReviewOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                RatingProgressBar(
                  rate: "5",
                  progress: 0.8,
                ),
                RatingProgressBar(
                  rate: "4",
                  progress: 0.41,
                ),
                RatingProgressBar(
                  rate: "3",
                  progress: 0.53,
                ),
                RatingProgressBar(
                  rate: "2",
                  progress: 0.2,
                ),
                RatingProgressBar(
                  rate: "1",
                  progress: 0.2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4.5",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  height: 10,
                ),
                Text(
                  "12 Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
