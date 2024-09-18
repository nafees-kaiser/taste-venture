import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/booking.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';

class BookingManager extends StatefulWidget {
  const BookingManager({super.key});

  @override
  State<BookingManager> createState() => _BookingManagerState();
}

class _BookingManagerState extends State<BookingManager> {
  // variables
  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> bookings = [];

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

  sendMessage(int i, bool isAccepted) {
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
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: SECONDARY_COLOR,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      postBooking(i, isAccepted, messageController.text);
                      Navigator.of(context)
                          .pop(); // This line closes the dialog
                    },
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

  Container BookingCard({required int i}) {
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
              infoText("Name", bookings[i]["user"]["name"].toString()),
              infoText("Mobile", bookings[i]["user"]["contact"].toString()),
              titleText("Booking Information:"),
              infoText("Date", bookings[i]["date"].toString()),
              infoText(
                  "Reserve for", bookings[i]["number_of_people"].toString()),
              infoText("Subtotal", bookings[i]["subtotal"].toString()),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SECONDARY_COLOR,
                          foregroundColor: Colors.white),
                      onPressed: () => sendMessage(i, false),
                      child: const Text("Reject")),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SECONDARY_COLOR,
                          foregroundColor: Colors.white),
                      onPressed: () => sendMessage(i, true),
                      child: const Text("Accept")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String tourspotId = "1";
  late ApiSettings viewAPI, acceptAPI, rejectAPI;

  late Future<void> _bookingFuture;

  @override
  void initState() {
    super.initState();
    viewAPI =
        ApiSettings(endPoint: 'tourspot/view-pending-booking/${tourspotId}');
    rejectAPI = ApiSettings(endPoint: 'tourspot/reject-booking');
    acceptAPI = ApiSettings(endPoint: 'tourspot/accept-booking');
    _bookingFuture = getBooking();
  }

  Future<void> getBooking() async {
    final response = await viewAPI.getMethod();
    try {
      if (response.statusCode == 200) {
        //List<dynamic> data = jsonDecode(response.body);
        dynamic data = jsonDecode(response.body);
        List<dynamic> bookingsData = data;
        // print(data);
        setState(() {
          bookings =
              bookingsData.map((item) => item as Map<String, dynamic>).toList();
        });
        // print(bookings[1]['user']);
      } else {
        // Handle the error
        throw Exception('Failed to load Bookings');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> postBooking(int i, bool accept, String message) async {
    final response = await (accept ? acceptAPI : rejectAPI).postMethod(
        jsonEncode(
            {"booking_id": bookings[i]["id"].toString(), "message": message}));
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(accept
                  ? 'Booking accepted successfully'
                  : 'Booking rejected successfully')),
        );
        // Refresh the page
        setState(() {
          _bookingFuture = getBooking();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking processing failed')),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Management"),
      ),
      body: FutureBuilder(
        future: _bookingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < bookings.length; i++) BookingCard(i: i)
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
