import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TAppbarThemeData {
  TAppbarThemeData();

  static const lightAppbar = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: BACKGROUND,
    iconTheme: IconThemeData(size: 24, color: TEXT),
    actionsIconTheme: IconThemeData(size: 24, color: TEXT),
    surfaceTintColor: BACKGROUND,
    titleTextStyle:
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: TEXT),
  );
}
