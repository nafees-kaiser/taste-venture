import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/manager_sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationManager extends StatefulWidget {
  const ReservationManager({super.key});

  @override
  State<ReservationManager> createState() => _ReservationManagerState();
}

class _ReservationManagerState extends State<ReservationManager> {
  // variables
  TextEditingController messageController = TextEditingController();

  late ApiSettings acceptAPI, rejectAPI;

  List<dynamic>? reservations;

  Future<void> getReservations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.get('userEmail');
    try {
      var response = await ApiSettings(endPoint: 'restaurant/reservation')
          .postMethod(jsonEncode({"email": email}));

      if (response.statusCode == 200) {
        setState(() {
          reservations = jsonDecode(response.body);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> postReservation(int id, bool accept, String message) async {
    final response = await (accept ? acceptAPI : rejectAPI).postMethod(
        jsonEncode({"reservation_id": id.toString(), "message": message}));
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(accept
                  ? 'Reservation accepted successfully'
                  : 'Reservation rejected successfully')),
        );
        // Refresh the page
        setState(() {
          _reservationFuture = getReservations();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reservation processing failed')),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  late Future<void> _reservationFuture;
  Future<void> _initializeData() async {
    rejectAPI = ApiSettings(endPoint: 'restaurant/reject-reservation');
    acceptAPI = ApiSettings(endPoint: 'restaurant/accept-reservation');
    _reservationFuture = getReservations();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rejectAPI = ApiSettings(endPoint: 'restaurant/reject-reservation');
    acceptAPI = ApiSettings(endPoint: 'restaurant/accept-reservation');
    _reservationFuture = _initializeData();
  }

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

  sendMessage(bool isAccepted, int id) {
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
                        postReservation(id, isAccepted, messageController.text),
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

  Container ReservationCard(data) {
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
              infoText("Name", data["user"]["name"]),
              infoText("Mobile", data["user"]["contact"]),
              titleText("Reservation Information:"),
              infoText("Date", data["date"]),
              infoText("Time", data["start_time"] + ' - ' + data["end_time"]),
              infoText("Reserve", data["number_of_people"].toString()),

              // Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () => sendMessage(false, data['id']),
                      child: const Text("Reject")),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      onPressed: () => sendMessage(true, data['id']),
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
      drawer: const ManagerSidebar(),
      appBar: AppBar(
        title: const Text("Reservation Manager"),
      ),
      body: (reservations == null || reservations!.isEmpty)
          ? const Center(
              child: Text(
                "No reservations",
                style: TextStyle(color: SECONDARY_BACKGROUND),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...reservations!.map((r) => ReservationCard(r))],
                ),
              ),
            ),
    );
  }
}
