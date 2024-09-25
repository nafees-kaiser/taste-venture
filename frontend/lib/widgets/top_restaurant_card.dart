import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/restaurant_info.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/navigation.dart';

class TopResCard extends StatefulWidget {
  String restaurantImage, restaurantName, restaurantAddress;
  int id;
  String restaurantRating;

  TopResCard(
      {super.key,
      required this.id,
      required this.restaurantImage,
      required this.restaurantName,
      required this.restaurantAddress,
      required this.restaurantRating});

  @override
  State<TopResCard> createState() => _TopResCardState();
}

class _TopResCardState extends State<TopResCard> {
  Future<Map<String, dynamic>?> getInfo() async {
    ApiSettings api = ApiSettings(endPoint: 'restaurant/${widget.id}');
    final response = await api.getMethod();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final restaurantInfo = await getInfo();
          if (restaurantInfo != null) {
            Navigation(context: context).materialNavigation(
              '/restaurant-info',
              () => RestaurantInfo.withRestaurant(restaurant: restaurantInfo),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No restaurant information available')),
            );
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching restaurant information')),
          );
        }
      },
      child: Container(
          width: 150,
          height: 220,
          child: Card.outlined(
            elevation: 5,
            surfaceTintColor: PRIMARY_COLOR,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              // side: BorderSide(
              //   color: DISABLE,
              //   width: 1,
              // )
            ),
            //color: BACKGROUND,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: widget.restaurantImage == null
                        ? const Image(
                            image: AssetImage('assets/image_filler.png'),
                            fit: BoxFit.cover,
                            height: 120,
                          )
                        : Image.network(
                            ApiSettings(endPoint: widget.restaurantImage)
                                .getUri(),
                            fit: BoxFit.cover,
                            height: 120,
                            errorBuilder: (context, error, stackTrace) =>
                                const Image(
                              image: AssetImage('assets/image_filler.png'),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),

                    // Image.asset(
                    //   widget.restaurantImage,
                    //   width: double.infinity,
                    //   height: 120,
                    //   fit: BoxFit.fitHeight,
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 0.0),
                  child: SizedBox(
                    width: 110,
                    child: Text(
                      widget.restaurantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: Colors.black),
                      SizedBox(
                        width: 110,
                        child: Text(
                          widget.restaurantAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 4.0, 0.0),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 13, color: Colors.black),
                      Text(
                        widget.restaurantRating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
