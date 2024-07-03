import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.controller,
    required List<DropdownMenuEntry<String>> menuItems,
    required String initialValue,
    this.label='',
  }) : _menuItems = menuItems, _initialValue = initialValue;

  final TextEditingController controller;
  final List<DropdownMenuEntry<String>> _menuItems;
  final String _initialValue;
  final String label;

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
        DropdownMenu<String>(
          controller: controller,
          dropdownMenuEntries: _menuItems,
          expandedInsets: EdgeInsets.zero,
          initialSelection: _initialValue,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}