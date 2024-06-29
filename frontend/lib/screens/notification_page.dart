import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: PRIMARY_COLOR,
              )),
        ],
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: NotificationPageContents(),
    );
  }
}

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

class NotificationCard extends StatelessWidget {
  final String spotName;
  final String userName;
  final DateTime notificationDate;
  final String notification;
  const NotificationCard({
    super.key, required this.spotName, required this.userName, required this.notificationDate, required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallCircleInsideBiggerCircle(
                  biggerCircleColor: PRIMARY_COLOR,
                  smallerCircleColor: Colors.white,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    spotName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  DateFormat('dd MMM, yyyy').format(notificationDate),
                  style: TextStyle(
                    color: SECONDARY_BACKGROUND,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi $userName',
                  // textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notification,
                  style: TextStyle(
                    color: SECONDARY_BACKGROUND,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SmallCircleInsideBiggerCircle extends StatelessWidget {
  final Color biggerCircleColor;
  final Color smallerCircleColor;
  const SmallCircleInsideBiggerCircle(
      {super.key,
      required this.biggerCircleColor,
      required this.smallerCircleColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: biggerCircleColor,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Positioned(
          left: 4,
          right: 4,
          bottom: 4,
          top: 4,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: smallerCircleColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    );
  }
}
