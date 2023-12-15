import 'package:flutter/material.dart';

class TextFieldDesingCustom {
  static final outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 12, 79, 146),
    ),
    borderRadius: BorderRadius.circular(30),
  );
  static final outlineInputBorderRed = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(30),
  );

  static TextStyle styleTextBold({required double fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }

  static TextStyle styleTextNormal({required double fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
    );
  }
}
