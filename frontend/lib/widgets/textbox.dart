import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String label;

  const Textbox(
      {super.key,
      this.controller,
      this.decoration,
      this.validator,
      this.obscureText = false,
      this.label = ''});
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
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: decoration,
          validator: validator,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
