import 'package:flutter/material.dart';

class RatingProgressBar extends StatelessWidget {
  final String rate;
  final double progress;
  const RatingProgressBar(
      {super.key, required this.progress, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        children: [
          Text(
            rate,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 170,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
