import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

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

                // Top reviewed restaurant
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
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
                Row(
                  children: [
                    TopResCard(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopResCard extends StatelessWidget {
  const TopResCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        height: 220,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    8.0, 8.0, 8.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/pizza.jpg",
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 0.0),
                child: SizedBox(
                  width: 130,
                  child: Text(
                    "Restaurant name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 13, color: Colors.black),
                    SizedBox(
                      width: 130,
                      child: Text(
                        "Restaurant address",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(8.0, 2.0, 4.0, 0.0),
                child: Row(
                  children: [
                    Icon(Icons.star,
                        size: 13, color: Colors.black),
                    Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
