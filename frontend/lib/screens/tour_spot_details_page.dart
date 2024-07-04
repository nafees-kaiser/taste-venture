import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TourSpotDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day-tour spot"),
      ),
      body: TourSpotDetailsPageContents(),
    );
  }
}

class TourSpotDetailsPageContents extends StatelessWidget {
  final String otherServices =
      '• Restaurant\n• Fitness centre\n• Air conditioning\n• Refrigerator in some rooms\n• Coffee maker';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 360,
                  width: double.infinity,
                  height: 157,
                  child:
                      const Image(image: AssetImage('assets/water_garden.png')),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Water Garden Resort & Spa',
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
                            'Dapnajore, Karatia, Tangail',
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
                              RatingStar(),
                              SizedBox(width: 3),
                              Text(
                                '384 reviews',
                                style: TextStyle(
                                  color: SECONDARY_BACKGROUND,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/review');
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
                              Text('Check-in time: 02:00 PM'),
                              Text('Check-out time: 12:00 PM'),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text('1.5 km'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Resort details',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 5),
                      ResortDetailsGrid(),
                      SizedBox(height: 20),
                      Text(
                        'Other services',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 3),
                      Text(otherServices),
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
            onPressed: () => Navigator.pushNamed(context, '/booking'),
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
  final resortDetailWifi = const ResortDetailsCard(
    icon: Icons.wifi,
    text: 'Free WiFi',
  );
  final resortDetailBreakfast = const ResortDetailsCard(
    icon: Icons.coffee,
    text: 'Free breakfast',
  );
  final resortDetailParking = const ResortDetailsCard(
    icon: Icons.local_parking,
    text: 'Free parking',
  );
  final resortDetailPool = const ResortDetailsCard(
    icon: Icons.pool,
    text: 'Indoor pool',
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            resortDetailWifi,
            SizedBox(width: 48),
            resortDetailBreakfast,
          ],
        ),
        SizedBox(height: 16),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            resortDetailParking,
            SizedBox(width: 30),
            resortDetailPool,
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

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Icon>.generate(
        5,
        (int index) => Icon(
          Icons.star_rate_rounded,
          color: RATING_FILL,
        ),
      ),
    );
  }
}
