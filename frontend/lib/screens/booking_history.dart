import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/widgets/customer_sidebar.dart';
import 'package:frontend/widgets/visiting_history_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key});

  Future<Map<String, dynamic>> _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tourspotId = prefs.getInt('spotId').toString();
    ApiSettings api =
        ApiSettings(endPoint: 'tourspot/view-booking-manager/$tourspotId');
    try {
      final response = await api.getMethod();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
      return {'tour-spot': []};
    } catch (e) {
      return {'tour-spot': []};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomerSidebar(),
      appBar: AppBar(
        title: const Text("Booking History"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _initializeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              (snapshot.data!['tour-spot'].isEmpty)) {
            return Center(child: Text('No Booking history available.'));
          }

          final List<dynamic> tourSpots = snapshot.data!['tour-spot'];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView(
              children: [
                if (tourSpots.isNotEmpty) ...[
                  Text(
                    'Visited Tour Spots',
                    // style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tourSpots.length,
                    itemBuilder: (context, index) {
                      final tourSpot = tourSpots[index];
                      final date = DateTime.parse(tourSpot['date']);
                      return GestureDetector(
                        child: VisitingHistoryCard(
                          spotImage: tourSpot['tourspot']['image'] ??
                              'assets/NorthEnd_second.jpg',
                          spotName: '${tourSpot['tourspot']['tourspot_name']}',
                          spotLocation: '${tourSpot['tourspot']['address']}',
                          visitingDate: date,
                          id: tourSpot['tourspot']['id'],
                          is_restautant: false,
                        ),
                        // onTap: () => Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TourSpotDetailsPage(
                        //       id: tourSpot['tourspot']['id'],
                        //     ),
                        //   ),
                        // ),
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
