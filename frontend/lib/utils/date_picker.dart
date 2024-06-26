import 'package:flutter/material.dart';

class DatePicker {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final BuildContext context;
  Function? onDateChange;

  DatePicker(
      {required this.context,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      this.onDateChange});

  void customShowDatePicker() {
    showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: initialDate,
      lastDate: lastDate,
    ).then((onValue) => onDateChange);
  }
}
