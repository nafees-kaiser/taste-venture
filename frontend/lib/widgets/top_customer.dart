import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';

class TopCustomer extends StatelessWidget {
  const TopCustomer({super.key});

  Future<List<Map<String, dynamic>>> getData() async {
    String url = 'tourspot/get-top-customers/1';
    ApiSettings api = ApiSettings(endPoint: url);
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Unable to fetch data');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
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
                    DataCell(Text(data['booking_count'].toString())),
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
