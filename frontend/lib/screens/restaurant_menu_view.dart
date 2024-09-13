import 'package:flutter/material.dart';
import 'package:frontend/widgets/menu_content.dart';

class RestaurantMenuView extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> data;
  // Map<String, List<Map<String, dynamic>>> menu = menuGroupByCategory(data["menu_item"]);

  RestaurantMenuView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: data == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: data.keys
                    .map((k) => MenuContent(
                          data: data[k],
                          title: k,
                        )).toList(),
              ),
      ),
    );
  }
}

