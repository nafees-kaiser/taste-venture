import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/information_card_without_icon.dart';

class ManagerVenueInformation extends StatelessWidget {
  const ManagerVenueInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Venue information",
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
                  Container(
                    width: 170,
                    margin: Theme.of(context).subSectionDividerPadding,
                    padding: Theme.of(context).insideCardPadding,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "10:23 AM",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 170,
                    margin: Theme.of(context).subSectionDividerPadding,
                    padding: Theme.of(context).insideCardPadding,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "11:00 PM",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InformationCardWithoutIcon(
                heading: "Description",
                text: "A tempting snacks",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
