import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class InformationCard extends StatefulWidget {
  final String heading;
  final String text;
  final void Function(String newText)? onTextSaved;

  InformationCard({
    super.key,
    required this.heading,
    required this.text,
    this.onTextSaved,
  });

  @override
  _InformationCardState createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
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
          Expanded(
            // Allow the text area to expand as much as needed
            child: Column(
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
                const SizedBox(height: 8.0),
                isEditing
                    ? TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter text',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          border:
                              OutlineInputBorder(), // Optional: Add a border to the input field
                        ),
                        maxLines:
                            null, // Allows the TextField to expand vertically
                        onSubmitted: (newValue) {
                          _handleSave();
                        },
                      )
                    : Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Optional: Handles overflow gracefully
                        maxLines:
                            5, // Limits the number of lines shown when not editing
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isEditing) {
                _handleSave();
              } else {
                setState(() {
                  isEditing = !isEditing;
                });
              }
            },
            child: Icon(
              isEditing ? Icons.done : Icons.edit,
              size: 24.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    if (widget.onTextSaved != null) {
      widget.onTextSaved!(_controller.text);
    }
    setState(() {
      isEditing = !isEditing;
    });
  }
}
