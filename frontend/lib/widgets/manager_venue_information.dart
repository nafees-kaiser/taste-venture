import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/information_card_without_icon.dart';

class ManagerVenueInformation extends StatelessWidget {
  const ManagerVenueInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: Theme.of(context).largemainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const InformationCardWithoutIcon(
                heading: "Venue Name",
                text: "Grand Tour venue",
              ),
              const InformationCardWithoutIcon(
                heading: "Official Email",
                text: "grand.tour420@gmail.com",
              ),
              const InformationCardWithoutIcon(
                heading: "Address",
                text: "6/41/2, jartrabari, Dhaka-1236",
              ),
              const InformationCardWithoutIcon(
                heading: "Phone Number",
                text: "01982711168",
              ),
              const InformationCardWithoutIcon(
                heading: "Tags",
                text: "Natural, Lake, Forest.",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Usual open time range",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
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
                      const Text(
                        "To :",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "To",
                            border: const OutlineInputBorder(),
                            contentPadding: Theme.of(context).defaultPadding,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description :",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
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
                    border: const OutlineInputBorder(),
                    contentPadding: Theme.of(context).defaultPadding,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
