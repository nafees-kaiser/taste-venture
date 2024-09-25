import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopCustomer extends StatelessWidget {
  final String userType;
  const TopCustomer({required this.userType, super.key});

  Future<List<Map<String, dynamic>>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? spotId = prefs.getInt('spotId');
    String url = userType == 'tour_manager'
        ? 'tourspot/get-top-customers'
        : 'restaurant/get-top-customers';
    ApiSettings api = ApiSettings(endPoint: '${url}/${spotId}');
    final response = await api.getMethod();

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonResponse = List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: Theme.of(context).subSectionDividerPadding,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Unable to fetch data');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No order yet');
            } else {
              return DataTable(
                border: TableBorder.all(width: 1),
                headingRowHeight: 40,
                sortColumnIndex: 0,
                sortAscending: true,
                dataTextStyle: const TextStyle(
                  fontSize: 15,
                ),
                headingTextStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text("Customer name")),
                  DataColumn(label: Text("No of Booking")),
                ],
                rows: snapshot.data!.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data['customer_name'] ?? '')),
                    DataCell(Text(data[userType == 'tour_manager'
                            ? 'booking_count'
                            : 'reservation_count']
                        .toString())),
                  ]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
