import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/menu_card.dart';

class MenuContent extends StatelessWidget {
  final data;
  final title;

  const MenuContent({
    super.key,
    required this.data,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Divider(
          color: PRIMARY_COLOR,
          indent: 125,
          endIndent: 125,
          thickness: 3,
        ),
        SizedBox(height: 13),

        ...data.map(
          (d) => Column(
            children: [
              MenuCard2(menuItem: d is MenuItem ? d : MenuItem.fromMap(d)),
              SizedBox(height: 10),
            ],
          ),
        ),
        // MenuCard2(),
        // SizedBox(height: 10),
        // MenuCard2(),
        // SizedBox(height: 10),
        // MenuCard2(),
        // SizedBox(height: 10),
        // MenuCard2(),
        // SizedBox(height: 10),
        // MenuCard2(),
        SizedBox(height: 5),
      ],
    );
  }
}
