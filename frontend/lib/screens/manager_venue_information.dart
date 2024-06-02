import 'package:flutter/material.dart';
import 'package:frontend/widgets/information_card_without_icon.dart';
import 'package:frontend/widgets/manager_menu_bottom_navigation.dart';

class ManagerVenueInformation extends StatelessWidget {
  const ManagerVenueInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Venue information",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(5),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              InformationCardWithoutIcon(
                heading: "Venue Name",
                text: "Grand Tour venue",
              ),
              InformationCardWithoutIcon(
                heading: "Official Email",
                text: "grand.tour420@gmail.com",
              ),
              InformationCardWithoutIcon(
                heading: "Address",
                text: "6/41/2, jartrabari, Dhaka-1236",
              ),
              InformationCardWithoutIcon(
                heading: "Phone Number",
                text: "01982711168",
              ),
              InformationCardWithoutIcon(
                heading: "Tags",
                text: "Natural, Lake, Forest.",
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Usual open time range",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From :",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "From",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To :",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "To",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description :",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: 140,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: "Write here..",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ManagerMenuBottomNavigation(),
    );
  }
}
