import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/elevated_button_theme.dart';
import 'package:frontend/utils/text_theme.dart';
import 'package:frontend/utils/custom_theme.dart';

class Scheme {
  Scheme();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: SECONDARY_COLOR,
    scaffoldBackgroundColor: BACKGROUND,
    textTheme: TextThemes.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: SECONDARY_COLOR,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextThemes.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
