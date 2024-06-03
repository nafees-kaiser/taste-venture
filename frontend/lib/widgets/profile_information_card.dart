import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class Profileinfocard extends StatelessWidget {
  final String name, text;
  final IconData icon;
  const Profileinfocard(
      {super.key, required this.name, required this.text, required this.icon});

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
                        icon,
                        size: 25,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 2,
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
