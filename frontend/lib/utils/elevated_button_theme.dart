import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: PRIMARY_COLOR,
      disabledForegroundColor: DISABLE,
      disabledBackgroundColor: DISABLE,
      // padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: SECONDARY_COLOR,
      disabledForegroundColor: DISABLE,
      disabledBackgroundColor: DISABLE,
      side: const BorderSide(color: SECONDARY_COLOR),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
