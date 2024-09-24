import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/widgets/edit_menu_form.dart';

class EditMenuPage extends StatefulWidget {
  int? id;

  EditMenuPage({super.key, this.id});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  late Future<Map<String, dynamic>?> data;
  Future<Map<String, dynamic>?> getMenu() async {
    if (widget.id != null) {
      try {
        final res =
            await ApiSettings(endPoint: 'restaurant/view-menu/${widget.id}')
                .getMethod();
        if (res.statusCode == 200) {
          return json.decode(res.body);
        }
        return null;
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(getMenu() != null){
      setState(() {
        data = getMenu();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>?>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: const CircularProgressIndicator(),
                );
              } else {
                return EditMenuForm(data: snapshot.data);
              }
            },
          ),
        ),
      ),
    );
  }
}
