import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profileinfocard extends StatefulWidget {
  final String name;
  String text;
  final IconData icon;
  Profileinfocard(
      {super.key, required this.name, required this.text, required this.icon});

  @override
  State<Profileinfocard> createState() => _ProfileinfocardState();
}

class _ProfileinfocardState extends State<Profileinfocard> {
  bool isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.text == 'Unknown' ? '' : widget.text);
  }

  Future<Map<String, dynamic>> getData(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    ApiSettings api = ApiSettings(endPoint: '$url');
    try {
      Map<String, dynamic> data = {
        "tag": (widget.name == 'Date of Birth')
            ? 'dob'
            : widget.name.toLowerCase(),
        "info": (_controller.text.isEmpty || _controller.text == 'Unknown')
            ? widget.text
            : _controller.text,
        "email": userEmail
      };
      final response = await api.postMethod(json.encode(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return responseData;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Theme.of(context).defaultPadding,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 25,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isEditing) {
                          // Save the edited text
                          getData('users/update-user-info');
                          widget.text = _controller.text.isEmpty
                              ? widget.text
                              : _controller.text;
                        }
                        isEditing = !isEditing;
                      });
                    },
                    child: Text(
                      isEditing ? "Save" : "Edit",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  )
                ],
              ),
              isEditing
                  ? Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      width: 240,
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter text',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      widget.text.isEmpty ? 'Unknown' : widget.text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
