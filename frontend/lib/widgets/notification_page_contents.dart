import 'package:flutter/material.dart';
import 'package:frontend/widgets/notification_card.dart';

class NotificationPageContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return NotificationCard(
            spotName: 'Pentagon Resort and Spa',
            userName: 'Nafees Kaiser',
            notificationDate: DateTime(2024, 6, 7),
            notification: 'Your reservation has been completed. See you on 10th June :)',
          );
        },
        itemCount: 20,
      ),
    );
  }
}