import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/flutter_toast.dart';
import 'package:frontend/utils/menu_group_by_category.dart';
import 'package:frontend/widgets/manager_menu_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerMenuInformations extends StatefulWidget {
  const ManagerMenuInformations({super.key});

  @override
  State<ManagerMenuInformations> createState() =>
      _ManagerMenuInformationsState();
}

class _ManagerMenuInformationsState extends State<ManagerMenuInformations> {
  Map<String, List<Map<String, dynamic>>> menuItems = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMenuItems();
  }

  Future<void> getMenuItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    try {
      var response = await ApiSettings(endPoint: 'restaurant/view-menu')
          .postMethod(jsonEncode({"email": email}));

      if (response.statusCode == 200) {
        var menuList = jsonDecode(response.body);
        setState(() {
          menuItems =
              menuGroupByCategory(List<Map<String, dynamic>>.from(menuList));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      errorToast("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu information",
        ),
      ),
      body: menuItems.isEmpty
          ? const Center(
              child: Text(
                "No menu added",
                style: TextStyle(color: SECONDARY_BACKGROUND),
              ),
            )
          : RefreshIndicator(
            onRefresh: getMenuItems,
            child: SingleChildScrollView(
                child: Padding(
                  padding: Theme.of(context).largemainPadding,
                  child: Column(
                    children: [
                      ...menuItems.keys.map(
                        (key) => Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: PRIMARY_COLOR,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                key,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            ...menuItems[key]!.map(
                              (menu) => ManagerMenuCard(
                                id: menu['id'],
                                image: menu['image'],
                                heading: menu['name'],
                                description: menu['description'],
                                price: menu['price'] + " Taka",
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-menu');
        },
        backgroundColor: PRIMARY_COLOR,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
