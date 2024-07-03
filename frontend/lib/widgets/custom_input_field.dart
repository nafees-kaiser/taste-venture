import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final double height; // Height parameter for input field
  final double width; // Width parameter for input field
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.height = 48.0, // Default height is 48.0
    this.width = double.infinity, // Default width is full width
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Container(
        width: widget.width, // Set the width of the input field
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF020D07),
              ),
            ),
            SizedBox(height: 7),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 10),
              // height: widget.height, // Set the height of the input field
              // decoration: BoxDecoration(
              //   border: Border.all(color: Color(0xFFBEC5D1)),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              child: TextField(
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                maxLines:
                    widget.keyboardType == TextInputType.multiline ? null : 1,
                onChanged: widget.onChanged,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF020D07),
                ),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(),
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
