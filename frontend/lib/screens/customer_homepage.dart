import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/restaurant_and_ratings.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/customer_sidebar.dart';
import 'package:frontend/widgets/top_restaurant_card.dart';
import 'package:frontend/widgets/top_tour_card.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({super.key});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  late Future<List<RestaurantAndRatings>> topRestaurants;
  ApiSettings top_restaurant_api =
      ApiSettings(endPoint: 'restaurant/get-top-restaurant');

  @override
  void initState() {
    super.initState();
    topRestaurants = fetchTopRestaurants();
  }

  Future<List<RestaurantAndRatings>> fetchTopRestaurants() async {
    final response = await top_restaurant_api.getMethod();

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((restaurant) => RestaurantAndRatings.fromJson(restaurant))
          .toList();
    } else {
      throw Exception('Failed to load top restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomerSidebar(),
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pin_drop,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Jatrabari, Dhaka-1236",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/notification'),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SearchBar
                SearchBar(
                    elevation: const WidgetStatePropertyAll(1),
                    backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
                    hintText: "Search",
                    hintStyle: const WidgetStatePropertyAll(TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    )),

                // Browse
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            child: Container(
                                width: double.infinity,
                                height: 170,
                                child: Card(
                                  elevation: 5,
                                  surfaceTintColor: PRIMARY_COLOR,
                                  color: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  //color: BACKGROUND,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: Text(
                                          "Browse Restaurant",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/restaurant.png",
                                            width: double.infinity,
                                            height: 80,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            onTap: () {
                              Navigator.pushNamed(context, "/restaurant-view");
                            }),
                      ),
                      Expanded(
                        child: GestureDetector(
                            child: Container(
                                width: double.infinity,
                                height: 170,
                                child: Card.outlined(
                                  elevation: 5,
                                  surfaceTintColor: SECONDARY_COLOR,
                                  color: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    //     side: BorderSide(
                                    //       color: DISABLE,
                                    //       width: 1,
                                    //     )
                                  ),
                                  // color: BACKGROUND,

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: Text(
                                          "Browse Tourist Venue",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/tourVenue.png",
                                            width: double.infinity,
                                            height: 80,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            onTap: () {
                              Navigator.pushNamed(context, "/tourspot-view");
                            }),
                      ),
                    ],
                  ),
                ),

                // Top reviewed restaurant
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                  child: Row(
                    children: [
                      const Text("Top reviewed restaurant",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const Expanded(child: SizedBox()),

                      // See all
                      GestureDetector(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Transform.scale(
                                  scaleX: -1,
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: PRIMARY_COLOR,
                                    size: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          // print("See all tapped");
                          Navigator.pushNamed(context, '/restaurant-view');
                        },
                      ),
                    ],
                  ),
                ),

                // Top reviewed restaurant Cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<List<RestaurantAndRatings>>(
                    future: topRestaurants,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return Row(
                          children: snapshot.data!.map((restaurant) {
                            return GestureDetector(
                              child: TopResCard(
                                restaurantImage: "assets/pizza.jpg",
                                restaurantName: restaurant.name,
                                restaurantAddress: restaurant.address,
                                restaurantRating: restaurant.averageRating,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    '/restaurant/information'); //restaurant_id = restaurant.id
                              },
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),

                // Top reviewed restaurant
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                  child: Row(
                    children: [
                      const Text("Top tour spots",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const Expanded(child: SizedBox()),

                      // See all
                      GestureDetector(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Transform.scale(
                                  scaleX: -1,
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: PRIMARY_COLOR,
                                    size: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          // print("See all tapped");
                          Navigator.pushNamed(context, '/tourspot-view');
                        },
                      ),
                    ],
                  ),
                ),
                // Top tour spot Cards
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          TopTourCard(
                            tourImage: "assets/tourVenue.png",
                            tourName: "Mirpur Picnic spot",
                            tourAddress: "14/A Mirpur-1, Dhaka-1211",
                            tourURL: '/tourspot-detail',
                          )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
