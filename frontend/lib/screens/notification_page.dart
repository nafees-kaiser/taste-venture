import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/customer_sidebar.dart';
import 'package:frontend/widgets/notification_page_contents.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = false;

  Future<void> deleteAllNotifications(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String url = 'users/remove-notification/$userId';

      ApiSettings api = ApiSettings(endPoint: url);
      final response = await api.deleteMethod();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All notifications deleted successfully')),
        );
        Navigator.pushNamed(context, '/customer-homepage');
      } else {
        throw Exception('Failed to delete notifications');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting notifications: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerSidebar(),
      appBar: AppBar(
        title: const Text("Notification"),
        actions: [
          IconButton(
            onPressed: isLoading
                ? null
                : () {
                    deleteAllNotifications(context);
                  },
            icon: const Icon(
              Icons.delete_outline,
              color: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          NotificationPageContents(),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
