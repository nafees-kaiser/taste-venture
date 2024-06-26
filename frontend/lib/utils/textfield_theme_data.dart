import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TTextFiledThemeData{
  TTextFiledThemeData();

  static InputDecorationTheme get customInputDecoration => InputDecorationTheme(
    // floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: BORDER_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BORDER_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: PRIMARY_COLOR, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintStyle: TextStyle(
            color: HINT_TEXT_COLOR,
            fontSize: 12
          ),
  );
}