import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/widgets/notification_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPageContents extends StatefulWidget {
  @override
  _NotificationPageContentsState createState() =>
      _NotificationPageContentsState();
}

class _NotificationPageContentsState extends State<NotificationPageContents> {
  List<dynamic> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String url = 'users/get-notifications/$userId';

    try {
      ApiSettings api = ApiSettings(endPoint: url);
      final response = await api.getMethod();
      print(response.bodyBytes);
      if (response.statusCode == 200) {
        print(response.statusCode);
        setState(() {
          notifications = json.decode(utf8.decode(response.bodyBytes));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (notifications.isEmpty) {
      return Center(
        child: Text(
          "Haven't any notifications",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];
          return NotificationCard(
            spotName: notification['heading'],
            userName: notification['user']['name'],
            notificationDate: notification['date'],
            notification: notification['text'],
          );
        },
      ),
    );
  }
}
