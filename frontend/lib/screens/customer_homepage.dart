import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/top_restaurant_card.dart';
import 'package:frontend/widgets/top_tour_card.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({super.key});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Homepage"),
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
                      GestureDetector(
                          child: SizedBox(
                              width: 170,
                              height: 170,
                              child: Card.outlined(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    side: BorderSide(
                                      color: DISABLE,
                                      width: 1,
                                    )),
                                color: BACKGROUND,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        borderRadius: BorderRadius.circular(20),
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
                      GestureDetector(
                          child: SizedBox(
                              width: 170,
                              height: 170,
                              child: Card.outlined(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    side: BorderSide(
                                      color: DISABLE,
                                      width: 1,
                                    )),
                                color: BACKGROUND,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        borderRadius: BorderRadius.circular(20),
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
                            Navigator.pushNamed(context, "/tourist_venue-view");
                          }),
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
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          GestureDetector(
                              child: TopResCard(
                                restaurantImage: "assets/pizza.jpg",
                                restaurantName: "PizzaBurg",
                                restaurantAddress: "14/A Mirpur-1, Dhaka-1211",
                                restaurantRating: 4.7,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/restaurant/information');
                              })
                      ],
                    )),

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
                          Navigator.pushNamed(context, '/restaurant-view');
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
                            tourImage: "assets/pizza.jpg",
                            tourName: "PizzaBurg",
                            tourAddress: "14/A Mirpur-1, Dhaka-1211",
                            tourURL: '/login',
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
