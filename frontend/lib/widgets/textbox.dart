import 'package:flutter/material.dart';

class Textbox extends StatelessWidget{
  final String hintText;

  const Textbox({super.key, required this.hintText});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        // label: Text("Full Name")
      ),
    );
  }
  
}