import 'package:flutter/material.dart';
import 'package:frontend/widgets/information_card_without_icon.dart';

class EditMenuForm extends StatefulWidget {
  Map<String, dynamic>? data;
  EditMenuForm({super.key, this.data});

  @override
  State<EditMenuForm> createState() => _EditMenuFormState();
}

class _EditMenuFormState extends State<EditMenuForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        InformationCardWithoutIcon(
          heading: "Heading",
          text: "Text",
        ),
      ],
    );
  }
}
