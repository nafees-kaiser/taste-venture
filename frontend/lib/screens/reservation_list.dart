import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({super.key});

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  // method
  Text infoText(String heading, String text) {
    return Text(
      "$heading: $text",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container ReservationCard() {
    return Container(
      width: 340,
      height: 260,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: DISABLE,
              width: 1,
            )),
        color: BACKGROUND,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText("Customer Information:"),
              infoText("Name", "Rafsan"),
              infoText("Mobile", "01545734368"),
              titleText("Reservation Information:"),
              infoText("Date", "12 JAN, 2024"),
              infoText("Time", "10 AM - 12 PM"),
              infoText("No. of Person", "2"),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () => print(false),
                      child: const Text("Reject")),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      onPressed: () => print(true),
                      child: const Text("Accept")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
