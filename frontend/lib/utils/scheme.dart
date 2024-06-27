import 'package:flutter/material.dart';
import 'package:frontend/utils/appbar_theme_data.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/dropdown_theme_data.dart';
import 'package:frontend/utils/elevated_button_theme.dart';
import 'package:frontend/utils/text_theme.dart';
import 'package:frontend/utils/textfield_theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:frontend/utils/custom_theme.dart';

class Scheme {
  Scheme();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: PRIMARY_COLOR,
      scaffoldBackgroundColor: BACKGROUND,
      textTheme: TextThemes.lightTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: TAppbarThemeData.lightAppbar,
      inputDecorationTheme: TTextFiledThemeData.customInputDecoration,
      menuTheme: TDropdownThemeData.customMenuTheme,
      fontFamily: GoogleFonts.getFont('Inter').fontFamily,
      );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: SECONDARY_COLOR,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextThemes.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFiledThemeData.customInputDecoration,
  );
}
