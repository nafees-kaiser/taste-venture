import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/review.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/bar_chart_component.dart';
import 'package:frontend/widgets/manager_sidebar_tourspot.dart';
import 'package:frontend/widgets/pie_chart_component.dart';
import 'package:frontend/widgets/manager_service_information.dart';
import 'package:frontend/widgets/manager_sidebar.dart';
import 'package:frontend/widgets/review_overview.dart';
import 'package:frontend/widgets/top_customer.dart';
import 'package:frontend/widgets/user_indivisual_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({super.key});

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getData(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? spotId = prefs.getInt('spotId');
    ApiSettings api = ApiSettings(endPoint: '${url}/${spotId}');
    final response = await api.getMethod();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userType = args['userType'] as String;

    return Scaffold(
      drawer: const ManagerSidebar(),
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pin_drop,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Jatrabari, Dhaka-1236",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: Theme.of(context).largeHorizontalAndVerticalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the ${userType == 'tour_manager' ? 'Tour Spot Dashboard' : 'Restaurant Dashboard'}!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: getData(userType == 'tour_manager'
                    ? 'tourspot/get-tourspot-selling-details'
                    : 'restaurant/get-restaurant-selling-details'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    // Handle error scenario
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ManagerServiceInformation(
                          icon: Icons.people,
                          percent:
                              "${data!['customer_change_percentage'].toString()}%",
                          header: "Total Customers",
                          number: data['total_customers'].toString(),
                        ),
                        ManagerServiceInformation(
                          icon: Icons.list_alt,
                          percent:
                              "${data['order_change_percentage'].toString()}%",
                          header: "Total Orders",
                          number: data['total_orders'].toString(),
                        ),
                        ManagerServiceInformation(
                          icon: Icons.widgets,
                          percent:
                              "${data['product_change_percentage'].toString()}%",
                          header: "Total Products",
                          number: data['total_product'].toString(),
                        ),
                        ManagerServiceInformation(
                          icon: Icons.payments,
                          percent:
                              "${data['revenue_change_percentage'].toString()}%",
                          header: "Total Revenue",
                          number: data['total_revenue'].toString(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Customer analysis",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        AspectRatio(
                          aspectRatio: 1.6,
                          child: BarChartComponent(
                            data: data['daywise_customer_count'],
                          ),
                        ),
                        if (userType == 'res_manager') ...[
                          const SizedBox(height: 10),
                          const Text(
                            "Food analysis",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (data['product_overview'].isNotEmpty)
                            PieChartComponent(
                              data: data['product_overview'],
                            )
                          else
                            const Text(
                              "No product data available.",
                              style: TextStyle(fontSize: 16),
                            ),
                        ]
                      ],
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "Top Customers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TopCustomer(
                userType: userType,
              ),
              FutureBuilder(
                future: getData(userType == 'tour_manager'
                    ? 'tourspot/get-daytour-review'
                    : 'restaurant/get-restaurant-reviews'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle error scenario
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    final ratings = data?['ratings'];
                    final avgRating = data?['avg_rating'];
                    final totalReviews = data?['total_reviews'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Recent Reviews",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ReviewOverview(
                          ratings: ratings,
                          avgRating: avgRating,
                          totalReviews: totalReviews,
                        ),
                        for (var review in data?['reviews'])
                          UserIndivisualReview(
                            userName: review['user']['name'],
                            reviewText: review['review'],
                            rating: review['rating'],
                            date: review['date'],
                          ),
                      ],
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
