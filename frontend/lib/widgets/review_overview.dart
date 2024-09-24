import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/rating_progress_bar.dart';

class ReviewOverview extends StatefulWidget {
  final Map<String, dynamic> ratings;
  final double avgRating;
  final int totalReviews;

  const ReviewOverview({
    required this.ratings,
    required this.avgRating,
    required this.totalReviews,
    super.key,
  });

  @override
  State<ReviewOverview> createState() => _ReviewOverviewState();
}

class _ReviewOverviewState extends State<ReviewOverview> {
  double _calculateProgress(int star) {
    if (widget.totalReviews == 0) return 0.0;
    return widget.ratings[star.toString()]! / widget.totalReviews;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: Theme.of(context).subSectionDividerPadding,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: List.generate(5, (index) {
                int star = 5 - index;
                return RatingProgressBar(
                  rate: star.toString(),
                  progress: _calculateProgress(star),
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.avgRating.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: index < (widget.avgRating.round())
                            ? Color.fromARGB(255, 161, 159, 47)
                            : Color(0xFFC4C4C4),
                        size: 16,
                      );
                    }),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.totalReviews} Reviews",
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
