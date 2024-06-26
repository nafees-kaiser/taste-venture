import 'package:flutter/material.dart';
import 'package:frontend/widgets/fav_card.dart';

class DataItem {
  final String image;
  final String foodName;
  final String storeName;
  final double rating;

  DataItem({
    required this.image,
    required this.foodName,
    required this.storeName,
    required this.rating,
  });
}

List<DataItem> data = [
  DataItem(
    image: 'assets/JeansCakes.png',
    foodName: 'Margherita Pizza',
    storeName: 'Pizzeria Uno',
    rating: 4.5,
  ),
  DataItem(
    image: 'assets/HotnSour.png',
    foodName: 'Margherita Pizza',
    storeName: 'Pizzeria Uno',
    rating: 4.5,
  ),
  DataItem(
    image: 'assets/images/food1.jpg',
    foodName: 'Margherita Pizza',
    storeName: 'Pizzeria Uno',
    rating: 4.5,
  ),
  DataItem(
    image: 'assets/images/food1.jpg',
    foodName: 'Margherita Pizza',
    storeName: 'Pizzeria Uno',
    rating: 4.5,
  ),
  DataItem(
    image: 'assets/images/food2.jpg',
    foodName: 'Sushi Platter',
    storeName: 'Sushi Zen',
    rating: 4.2,
  ),
  DataItem(
    image: 'assets/images/food3.jpg',
    foodName: 'Grilled Salmon',
    storeName: 'Seafood Grill',
    rating: 4.8,
  ),
  DataItem(
    image: 'assets/images/food4.jpg',
    foodName: 'Chocolate Cake',
    storeName: 'Sweet Treats Bakery',
    rating: 4.7,
  ),
];

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavCard(
                  image: "",
                  foodfoodName: "",
                  storefoodName: "",
                  rating: 0.0,
                )
              ],
            ),
          ),
        ));
  }
}
