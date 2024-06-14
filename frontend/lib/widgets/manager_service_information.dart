import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class ManagerServiceInformation extends StatelessWidget {
  final IconData icon;
  final String header, number, percent;
  const ManagerServiceInformation(
      {super.key,
      required this.icon,
      required this.header,
      required this.number,
      required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      height: 175,
      padding: Theme.of(context).insideCardPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(
            header,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 23,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.grey,
            height: 2,
            thickness: 1,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            percent,
            style: TextStyle(
              color: percent.startsWith('-') ? Colors.red : Colors.green,
              fontSize: 16,
            ),
          ),
          const Text(
            "this month",
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
