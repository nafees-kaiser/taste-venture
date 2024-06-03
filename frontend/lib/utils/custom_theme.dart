import 'package:flutter/material.dart';

extension CustomThemeData on ThemeData {
  EdgeInsets get defaultPadding => const EdgeInsets.all(16.0);
  EdgeInsets get verticalPadding => const EdgeInsets.symmetric(vertical: 12.0);
  EdgeInsets get horizontalPadding =>
      const EdgeInsets.symmetric(horizontal: 8.0);
}
