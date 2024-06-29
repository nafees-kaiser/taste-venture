import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/small_circle_inside_bigger_circle.dart';
import 'package:intl/intl.dart';

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