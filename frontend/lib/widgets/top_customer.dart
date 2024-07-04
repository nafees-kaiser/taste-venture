import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class TopCustomer extends StatelessWidget {
  const TopCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: Theme.of(context).subSectionDividerPadding,
        child: DataTable(
            border: TableBorder.all(
              width: 1,
            ),
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
            rows: const [
              DataRow(cells: [
                DataCell(Text('Akash')),
                DataCell(Text("90")),
              ]),
              DataRow(cells: [
                DataCell(Text('Halim')),
                DataCell(Text("76")),
              ]),
              DataRow(cells: [
                DataCell(Text('Habib')),
                DataCell(Text("34")),
              ]),
              DataRow(cells: [
                DataCell(Text('Nafees')),
                DataCell(Text("27")),
              ]),
              DataRow(cells: [
                DataCell(Text('Shahabuddin')),
                DataCell(Text("10")),
              ]),
            ]),
      ),
    );
  }
}
