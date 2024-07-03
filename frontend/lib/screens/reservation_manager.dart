import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class ReservationManager extends StatefulWidget {
  const ReservationManager({super.key});

  @override
  State<ReservationManager> createState() => _ReservationManagerState();
}

class _ReservationManagerState extends State<ReservationManager> {
  // variables
  TextEditingController messageController = TextEditingController();

  // methods
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

  sendMessage(bool isAccepted) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Container(
        height: 200,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText("Send Message"),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(149, 149, 149, 1),
                        ),
                      ),
                      hintText: "Write message here...",
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(149, 149, 149, 1))),
                ),
                // send button
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/reservation-list'),
                    child: const SizedBox(
                        height: 25,
                        width: 60,
                        child: Center(child: Text("Send")))),
              ],
            ),
          ),
        ),
      )),
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
                      onPressed: () => sendMessage(false),
                      child: const Text("Reject")),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      onPressed: () => sendMessage(true),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservation Manager"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (int i = 0; i < 3; i++) ReservationCard()],
            ),
          ),
        ));
  }
}
