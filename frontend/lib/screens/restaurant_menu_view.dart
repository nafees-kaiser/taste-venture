import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/menu_card.dart';

class RestaurantMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
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
            SizedBox(height: 10),
            MenuCard2(),
            SizedBox(height: 10),
            MenuCard2(),
            SizedBox(height: 10),
            MenuCard2(),
            SizedBox(height: 10),
            MenuCard2(),
            // SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
