import 'package:flutter/material.dart';
class SmallCircleInsideBiggerCircle extends StatelessWidget {
  final Color biggerCircleColor;
  final Color smallerCircleColor;
  const SmallCircleInsideBiggerCircle(
      {super.key,
      required this.biggerCircleColor,
      required this.smallerCircleColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: biggerCircleColor,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Positioned(
          left: 4,
          right: 4,
          bottom: 4,
          top: 4,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: smallerCircleColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    );
  }
}
