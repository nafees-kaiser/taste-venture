import 'package:flutter/material.dart';
import 'package:frontend/widgets/fav_card.dart';

class DataItem {
  String image, foodName, storeName;
  double rating;

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
    foodName: 'Jean’s Cakes',
    storeName: 'Johar Town',
    rating: 4.9,
  ),
  DataItem(
    image: 'assets/HotnSour.png',
    foodName: 'Hot n Sour',
    storeName: 'Johar Town',
    rating: 4.2,
  ),
  DataItem(
    image: 'assets/JohnnyJuice.png',
    foodName: 'Johnny Juice',
    storeName: 'Wapda Town',
    rating: 4.3,
  ),
  DataItem(
    image: 'assets/MargheritaPizza.jpg',
    foodName: 'Margherita Pizza',
    storeName: 'Pizzeria Uno',
    rating: 4.5,
  ),
  DataItem(
    image: 'assets/SushiPlatter.jpg',
    foodName: 'Sushi Platter',
    storeName: 'Sushi Zen',
    rating: 4.2,
  ),
  DataItem(
    image: 'assets/GrilledSalmon.jpg',
    foodName: 'Grilled Salmon',
    storeName: 'Seafood Grill',
    rating: 4.8,
  ),
  DataItem(
    image: 'assets/ChocolateCake.jpg',
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
                for (int i = 0; i < data.length; i++)
                  FavCard(
                    image: data[i].image,
                    foodName: data[i].foodName,
                    storeName: data[i].storeName,
                    rating: data[i].rating,
                  )
              ],
            ),
          ),
        ));
  }
}
