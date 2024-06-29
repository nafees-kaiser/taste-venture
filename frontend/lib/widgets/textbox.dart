import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String optionalLabel;

  const Textbox({super.key, this.controller, this.decoration, this.validator, this.obscureText=false, this.optionalLabel=''});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(optionalLabel),
        // SizedBox(height: 5),
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
