import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/notification_page_contents.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline,
                color: PRIMARY_COLOR,
              )),
        ],
      ),
      body: NotificationPageContents(),
    );
  }
}





