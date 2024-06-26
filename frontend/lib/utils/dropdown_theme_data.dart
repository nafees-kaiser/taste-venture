import 'package:flutter/material.dart';

class TDropdownThemeData{
  TDropdownThemeData();
  // DropdownMenuThemeData get customDropDownTheme => DropdownMenuThemeData(
  //   menuStyle: MenuStyle(
  //     minimumSize: Size(double.infinity,0)
  //   )
  // );
  // MenuThemeData get customMenuTheme => const MenuThemeData(
  //     style: MenuStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
  //   );
  static final customMenuTheme = const MenuThemeData(
      style: MenuStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
    );
}