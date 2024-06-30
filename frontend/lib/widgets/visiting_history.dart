import 'package:flutter/material.dart';
import 'package:frontend/widgets/visiting_history_card.dart';

class VisitingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: VisitingHistoryCard(
              spotImage: 'assets/NorthEnd_second.jpg',
              spotName: 'North End',
              spotLocation: 'Banani, Dhaka',
              visitingDate: DateTime(2023, 1, 1),
            ),
            onTap: () =>
                Navigator.pushNamed(context, '/restaurant/information'),
          );
        },
        itemCount: 20,
      ),
    );
    
  }
}
