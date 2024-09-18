import 'package:flutter/material.dart';
import 'package:frontend/screens/restaurant_detail.dart';
import 'package:frontend/screens/restaurant_menu_view.dart';
import 'package:frontend/screens/review.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/menu_group_by_category.dart';

class RestaurantInfo extends StatefulWidget {
  final Map<String, dynamic>? restaurant;

  RestaurantInfo({super.key, this.restaurant = null});

  RestaurantInfo.withRestaurant({super.key, required this.restaurant});

  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  late List<Widget> _pages;
  late Map<String, List<Map<String, dynamic>>> menu;
  bool isInitialized = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    // setState(() {
    // print(widget.restaurant?["menu_item"] is List<dynamic>);
    menu = menuGroupByCategory(
        List<Map<String, dynamic>>.from(widget.restaurant?["menu_item"]));
    // });

    _pages = <Widget>[
      RestaurantDetail(data: widget.restaurant!),
      RestaurantMenuView(data: menu),
      Reviews(
        id: widget.restaurant?['id'],
        is_restaurant: true,
      ),
    ];

    setState(() {
      isInitialized = true;
      // menu = menuGroupByCategory(widget.restaurant?["menu_item"]);
    });
  }

  // static final List<Widget> _pages = <Widget>[
  //   RestaurantDetail(data: restaurant),
  //   RestaurantMenuView(),
  //   Reviews(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Information"),
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: isInitialized
          ? _pages.elementAt(page)
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Details",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: "Reviews",
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: page,
        selectedItemColor: PRIMARY_COLOR,
        onTap: (index) => setState(() {
          page = index;
        }),
      ),
    );
  }
}
