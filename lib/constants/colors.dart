import 'package:flutter/material.dart';

class SharedColorPalette {
  Color black = Colors.black;
  Color white = Colors.white;
  Color greyIcon = const Color(0xFFCBD5E1);
  Color greyText = const Color(0xFF64748B);
  Color mainDisable = Color(0xFFffba3f);
  Color main = Color(0xFFff9715);
  Color main2 = const Color(0xFF294F87);
  Color mainDisable2 = const Color(0xFF70819c);

  Color validate = const Color(0xFF03C923);
}

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, primaryColor: const Color(0xFF294F87));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, primaryColor: const Color(0xFF294F87));
