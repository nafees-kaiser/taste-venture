import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/restaurant_info.dart';
import 'package:frontend/screens/tour_spot_details_page.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/navigation.dart';
import 'package:frontend/widgets/customer_sidebar.dart';
import 'package:frontend/widgets/visiting_history_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitingHistoryPage extends StatelessWidget {
  Future<Map<String, dynamic>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    ApiSettings api =
        ApiSettings(endPoint: 'restaurant/visiting-history/$userId');

    try {
      final response = await api.getMethod();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
      return {'restaurant': [], 'tour-spot': []};
    } catch (e) {
      return {'restaurant': [], 'tour-spot': []};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomerSidebar(),
      appBar: AppBar(
        title: const Text("Visiting History"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              (snapshot.data!['restaurant'].isEmpty &&
                  snapshot.data!['tour-spot'].isEmpty)) {
            return Center(child: Text('No visiting history available.'));
          }

          final List<dynamic> restaurants = snapshot.data!['restaurant'];
          final List<dynamic> tourSpots = snapshot.data!['tour-spot'];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView(
              children: [
                if (restaurants.isNotEmpty) ...[
                  Text(
                    'Visited Restaurants',
                    // style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      final date = DateTime.parse(restaurant['date']);
                      return GestureDetector(
                        child: VisitingHistoryCard(
                          spotImage: restaurant['restaurant']['image'] ??
                              'assets/NorthEnd_second.jpg',
                          spotName:
                              "${restaurant['restaurant']['restaurant_name']}",
                          spotLocation:
                              '${restaurant['restaurant']['address']}',
                          visitingDate: date,
                          id: restaurant['restaurant']['id'],
                          is_restautant: true,
                        ),
                        onTap: () =>
                            Navigation(context: context).materialNavigation(
                          '/restaurant-info',
                          () => RestaurantInfo.withRestaurant(
                              restaurant: restaurant['restaurant']),
                        ),
                      );
                    },
                  ),
                ],
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TourSpotDetailsPage(
                              id: tourSpot['tourspot']['id'],
                            ),
                          ),
                        ),
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
