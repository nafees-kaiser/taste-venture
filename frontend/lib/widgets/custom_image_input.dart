import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class CustomImageInput extends StatelessWidget {
  final String label;
  final List<XFile> inputImage;
  final void Function(XFile)? onImageSelected;
  final void Function(XFile, int)? onImageRemoved;

  const CustomImageInput(
      {super.key,
      required this.label,
      required this.inputImage,
      this.onImageSelected,
      this.onImageRemoved});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 5),
        ImageInput(
          images: inputImage,
          onImageSelected: onImageSelected,
          onImageRemoved: onImageRemoved,
        ),
      ],
    );
  }
}
