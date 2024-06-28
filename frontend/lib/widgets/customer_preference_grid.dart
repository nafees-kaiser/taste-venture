import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/preference_contents.dart';

class CustomerPreferenceGrid extends StatelessWidget {
  final void Function(int) selectPreference;
  final int itemSize;
  final List<String>? image;
  final List<String>? title;
  const CustomerPreferenceGrid(
      {super.key,
      required this.selectPreference,
      required this.itemSize,
      this.image,
      this.title});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        // childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return PreferenceContents(
          // cuisineImagePath: image[index],
          // cuisineType: title[index],
          gestureFunction: () => selectPreference(index),
        );
      },
      itemCount: itemSize,
    );
  }
}