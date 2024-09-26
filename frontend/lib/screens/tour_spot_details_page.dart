import 'package:flutter/material.dart';
import 'package:frontend/screens/booking.dart';
import 'package:frontend/utils/build_image_file.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/api_settings.dart';
import 'dart:convert';

class TourSpotDetailsPage extends StatelessWidget {
  final int id;

  TourSpotDetailsPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day-tour spot"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTourSpotDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else if (snapshot.hasData) {
            return TourSpotDetailsPageContents(data: snapshot.data!);
          } else {
            return Center(child: Text('Unknown error occurred'));
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchTourSpotDetails(int id) async {
    ApiSettings api = ApiSettings(endPoint: 'tourspot/view-list/$id');
    final response = await api.getMethod();
    return json.decode(response.body);
  }
}

class TourSpotDetailsPageContents extends StatelessWidget {
  final Map<String, dynamic> data;

  TourSpotDetailsPageContents({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tourspotData = data['tourspot'] ?? {};
    final otherServices = tourspotData['other_services'] ?? '';

    final averageRating = data['avg_rating'] ?? 0.0;
    final totalReviews = data['total_reviews'] ?? 0;

    List<String> servicesList = otherServices is String
        ? otherServices.split(',').map((e) => e.trim()).toList()
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 157,
                  child: tourspotData['image'] == null
                      ? const Image(
                          image: AssetImage('assets/image_filler.png'),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          ApiSettings(endPoint: urlModify(tourspotData['image'])).getUri(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Image(
                            image: AssetImage('assets/image_filler.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                  // const Image(image: AssetImage('assets/water_garden.png')),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourspotData['tourspot_name'] ?? '',
                        style: theme.textTheme.headlineMedium,
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: SECONDARY_BACKGROUND,
                          ),
                          Text(
                            tourspotData['address'] ?? '',
                            style: TextStyle(
                              color: SECONDARY_BACKGROUND,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // RatingStar(),
                              Container(
                                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      color: index <
                                              (averageRating?.round() ?? 0)
                                          ? Color.fromARGB(255, 161, 159, 47)
                                          : Color(0xFFC4C4C4),
                                      size: 16,
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                '$totalReviews reviews',
                                style: TextStyle(
                                  color: SECONDARY_BACKGROUND,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/review',
                                  arguments: [tourspotData['id'] ?? 1, false]);
                            },
                            child: Text(
                              'See all reviews',
                              style: TextStyle(color: SECONDARY_COLOR),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.black,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Open today',
                            style: TextStyle(color: SECONDARY_BACKGROUND),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Check-in time: ${tourspotData['opening_time']}'),
                              Text(
                                  'Check-out time: ${tourspotData['closing_time']}'),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Icon(Icons.location_on_outlined),
                          //     Text('1.5 km'),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Tourspot details',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 5),
                      ResortDetailsGrid(tourspotData: tourspotData),
                      SizedBox(height: 20),
                      Text(
                        'Other services',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: servicesList
                              .map((service) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            service,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Booking(
                  fee: tourspotData['entry_fee'],
                  tourspotId: tourspotData['id'],
                ),
              ),
            ),
            // Navigator.pushNamed(context, '/booking'),
            child: Text('Reserve'),
            style: ElevatedButton.styleFrom(
              backgroundColor: SECONDARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class ResortDetailsGrid extends StatelessWidget {
  final Map<String, dynamic> tourspotData;

  ResortDetailsGrid({required this.tourspotData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ResortDetailsCard(
              icon: tourspotData['wifi'] == 'Yes'
                  ? Icons.wifi
                  : Icons.signal_wifi_connected_no_internet_4_rounded,
              text: tourspotData['wifi'] == 'Yes' ? 'Free WiFi' : 'No WiFi',
            ),
            SizedBox(width: 48),
            ResortDetailsCard(
              icon: tourspotData['food'] == 'Yes'
                  ? Icons.coffee
                  : Icons.no_food_outlined,
              text: tourspotData['food'] == 'Yes'
                  ? 'Free breakfast'
                  : 'No breakfast',
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            ResortDetailsCard(
              icon: tourspotData['parking'] == 'Yes'
                  ? Icons.local_parking
                  : Icons.car_crash,
              text: tourspotData['parking'] == 'Yes'
                  ? 'Free parking'
                  : 'No parking',
            ),
            SizedBox(width: 30),
            ResortDetailsCard(
              icon: tourspotData['pool'] == 'Yes'
                  ? Icons.pool
                  : Icons.clear_outlined,
              text: tourspotData['pool'] == 'Yes' ? 'Indoor pool' : 'No pool',
            ),
          ],
        ),
      ],
    );
  }
}

class ResortDetailsCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const ResortDetailsCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

// class RatingStar extends StatelessWidget {
//   const RatingStar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List<Icon>.generate(
//         5,
//         (int index) => Icon(
//           Icons.star_rate_rounded,
//           color: RATING_FILL,
//         ),
//       ),
//     );
//   }
// }
