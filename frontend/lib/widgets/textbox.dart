import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;

  const Textbox({super.key, this.controller, this.decoration, this.validator});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: decoration,
          validator: validator,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
