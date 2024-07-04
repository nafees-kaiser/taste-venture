import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/menu_card.dart';

class InitialMenuContent extends StatefulWidget {
  InitialMenuContent({super.key});

  @override
  _InitialMenuContentState createState() => _InitialMenuContentState();
}

class _InitialMenuContentState extends State<InitialMenuContent> {
  List<String>? menuItems = [
    'Pizza',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: (menuItems == null || menuItems!.isEmpty)
              ? Center(
                  child: Text(
                    'Add one or more menu items',
                    style: TextStyle(color: SECONDARY_BACKGROUND),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Main dish',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(
                        color: PRIMARY_COLOR,
                        indent: 125,
                        endIndent: 125,
                        thickness: 3,
                      ),
                      SizedBox(height: 13),
                      MenuCard2(),
                    ],
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/add-menu'),
              child: Text('Add'),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: (menuItems == null || menuItems!.isEmpty)
                  ? null
                  : () {
                      Navigator.pushNamed(context, '/manager-home');
                    },
              child: Text('Done'),
            ),
          ],
        ),
      ],
    );
  }
}
