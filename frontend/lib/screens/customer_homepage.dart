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
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: Color.fromRGBO(252, 81, 16, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print("See all tapped");
                        },
                      ),
                    ],
                  ),
                ),

                // Top reviewed restaurant Cards
                Row(
                  children: [
                    Container(
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
                                child: Text(
                                  "Restaurant name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 4.0),
                                child: Text(
                                  "Restaurant address",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
                                child: Text(
                                  "Restaurant rating",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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
