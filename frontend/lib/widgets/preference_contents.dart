import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class PreferenceContents extends StatefulWidget {
  final String cuisineImagePath;
  final String cuisineType;
  final void Function()? gestureFunction;

  PreferenceContents(
      {super.key,
      this.cuisineImagePath = 'assets/pizza.jpg',
      this.cuisineType = 'Name of cuisine',
      this.gestureFunction});

  @override
  _PreferenceContentsState createState() => _PreferenceContentsState();
}

class _PreferenceContentsState extends State<PreferenceContents> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.gestureFunction!();
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Column(
        children: [
          SizedBox(height: 3),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: SECONDARY_BACKGROUND,
              border: isSelected
                  ? Border.all(
                      color: Colors.black,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside)
                  : null,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image(
              image: AssetImage(widget.cuisineImagePath),
            ),
            height: 103,
            width: 155,
          ),
          SizedBox(height: 5),
          Text(
            widget.cuisineType,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
