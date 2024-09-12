import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/models/restaurant.dart';
import 'package:frontend/screens/add_menu_page.dart';
import 'package:frontend/screens/otp_page.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/menu_group_by_category.dart';
import 'package:frontend/utils/navigation.dart';
import 'package:frontend/widgets/menu_card.dart';
import 'package:frontend/widgets/menu_content.dart';

class InitialMenuContent extends StatefulWidget {
  final RestaurantModel? restaurantModel;
  InitialMenuContent({super.key, this.restaurantModel});

  @override
  _InitialMenuContentState createState() => _InitialMenuContentState();
}

class _InitialMenuContentState extends State<InitialMenuContent> {
  List<String>? menuItemsEg = ['pizza'];
  List<MenuItem> menuItems = [];
  var updatedMenuItems = {};
  late RestaurantModel? restaurantModel;
  ApiSettings api = ApiSettings(endPoint: '/restaurant/add-restaurant');

  void addMenuItems(MenuItem menuItem) {
    setState(() {
      menuItems.add(menuItem);
      updatedMenuItems =
        menuGroupByCategory(menuItems.map((m) => m.toMap()).toList());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurantModel = widget.restaurantModel;
    updatedMenuItems =
        menuGroupByCategory(menuItems.map((m) => m.toMap()).toList());
  }

  void addRestaurant() async {
    var restaurantData = restaurantModel?.toMap();
    restaurantData?['menu_item'] = menuItems.map((m) => m.toMap()).toList();
    // var menuItemsData = jsonEncode(menuItems);
    var data = jsonEncode(restaurantData);
    // print(data);

    try {
      final response = await api.postMethod(data);

      if (response.statusCode == 201) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //         content:
        //             Text('${response.statusCode}')),
        //   );

        Navigation(context: context).materialNavigation(
            '/otp-page',
            () => OtpPage.setEmail(
                  email: restaurantModel?.email,
                  nextPath: '/login',
                ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: (menuItems.isEmpty)
              ? Center(
                  child: Text(
                    'Add one or more menu items',
                    style: TextStyle(color: SECONDARY_BACKGROUND),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Text(
                      //   'Main dish',
                      //   style: Theme.of(context).textTheme.headlineSmall,
                      // ),
                      // Divider(
                      //   color: PRIMARY_COLOR,
                      //   indent: 125,
                      //   endIndent: 125,
                      //   thickness: 3,
                      // ),
                      // SizedBox(height: 13),
                      // ...menuItems.map(
                      //   (m) => Column(
                      //     children: [
                      //       SizedBox(height: 10),
                      //       MenuCard2(
                      //         menuItem: m,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      ...updatedMenuItems.keys.map(
                        (m) => MenuContent(
                          data: updatedMenuItems[m],
                          title: m,
                        ),
                      ),
                      // MenuCard2()
                    ],
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMenuPage(
                    endPoint: '/restaurant/add-restaurant',
                    addMenuItems: addMenuItems,
                    isAddRestaurant: true,
                  ),
                ),
              ),
              child: Text('Add'),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: (menuItemsEg == null || menuItemsEg!.isEmpty)
                  ? null
                  : addRestaurant,
              child: Text('Done'),
            ),
          ],
        ),
      ],
    );
  }
}
