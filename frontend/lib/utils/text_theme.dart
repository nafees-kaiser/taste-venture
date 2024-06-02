import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TextThemes {
  TextThemes();

  static TextTheme lightTheme = TextTheme(
      headlineLarge: const TextStyle()
          .copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: TEXT),
      headlineMedium: const TextStyle()
          .copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: TEXT),
      headlineSmall: const TextStyle()
          .copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: TEXT),
      titleLarge: const TextStyle()
          .copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: TEXT),
      titleMedium: const TextStyle()
          .copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: TEXT),
      titleSmall: const TextStyle()
          .copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: TEXT),
      bodyLarge: const TextStyle()
          .copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: TEXT),
      bodyMedium: const TextStyle()
          .copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: TEXT),
      bodySmall: const TextStyle().copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: TEXT.withOpacity(0.5)));

  static TextTheme darkTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
      titleSmall: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
      bodySmall: const TextStyle().copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.5)));
}
