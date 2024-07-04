import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class InformationCardWithoutIcon extends StatefulWidget {
  String heading, text;
  InformationCardWithoutIcon(
      {super.key, required this.heading, required this.text});

  @override
  _InformationCardWithoutIconState createState() =>
      _InformationCardWithoutIconState();
}

class _InformationCardWithoutIconState
    extends State<InformationCardWithoutIcon> {
  bool isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: Theme.of(context).subSectionDividerPadding,
      padding: Theme.of(context).insideCardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.heading,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              isEditing
                  ? Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      width: 240,
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter text',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (isEditing) {
                  // Save the edited text
                  widget.text = _controller.text;
                }
                isEditing = !isEditing;
              });
            },
            child: Text(
              isEditing ? "Save" : "Edit",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
