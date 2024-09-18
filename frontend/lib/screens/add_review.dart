import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReview extends StatefulWidget {
  final int id;
  final bool isRestaurant;
  const AddReview({required this.isRestaurant, required this.id, super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController _controller = TextEditingController();
  double _rating = 5;
  Future<Map<String, dynamic>> getData() async {
    String url;
    if (widget.isRestaurant) {
      url = 'restaurant';
    } else {
      url = 'tourspot/view-list';
    }
    ApiSettings api = ApiSettings(endPoint: '${url}/${widget.id}');
    final response = await api.getMethod();

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void saveReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    Map<String, dynamic> data;
    String url;
    if (widget.isRestaurant) {
      data = {
        "review": _controller.text,
        "email": userEmail,
        "rating": _rating,
        "restaurant_id": widget.id,
      };
      url = 'restaurant/add-restaurant-review';
    } else {
      data = {
        "review": _controller.text,
        "email": userEmail,
        "rating": _rating,
        "dayTourSpot_id": widget.id,
      };
      url = 'tourspot/add-daytour-review';
    }
    ApiSettings api = ApiSettings(endPoint: '${url}');
    final response = await api.postMethod(json.encode(data));
    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: Theme.of(context).largemainPadding,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['tourspot_name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 10),
                                  Text(
                                    data['address'] ?? 'Unknown location',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: Theme.of(context).sectionDividerPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                                'assets/NorthEnd.jpg'), // Update with dynamic image if needed
                          ),
                        ),
                        Container(
                          padding: Theme.of(context).subSectionDividerPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule, size: 20),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Open Today",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${data['opening_time']} - ${data['closing_time']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.fork_right, color: PRIMARY_COLOR),
                                  if (widget.isRestaurant)
                                    Text(
                                      "Visit the Restaurant",
                                      style: TextStyle(
                                        color: PRIMARY_COLOR,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  else
                                    Text(
                                      "Visit the Tourspot",
                                      style: TextStyle(
                                        color: PRIMARY_COLOR,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        Theme.of(context).largeHorizontalAndVerticalPadding,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 243, 243),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "How much do you rate?",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: Theme.of(context).subSectionDividerPadding,
                          child: RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 35,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: Theme.of(context).subSectionDividerPadding,
                          child: const Text(
                            textAlign: TextAlign.center,
                            "Please share your opinion\nabout the product",
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: Theme.of(context).subSectionDividerPadding,
                          child: SizedBox(
                            height: 100,
                            child: TextField(
                              maxLines: null,
                              expands: true,
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Enter your Review',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(20),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            saveReview();
                          },
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(
                                const Size(double.infinity, 45)),
                          ),
                          child: const Text(
                            "SEND REVIEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
