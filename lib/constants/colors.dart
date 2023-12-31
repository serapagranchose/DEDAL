import 'package:flutter/material.dart';

class SharedColorPalette {
  // Blue DEDAL:
  Color primary = const Color(0xFF294F87);
  Color lightPrimary = const Color(0xFF70819c);
  // Orange DEDAL:
  Color secondary = const Color(0xFFff9715);
  Color lightSecondary = const Color(0xFFffba3f);

  // Usually used for buttons or popups
  // Lightmode: white, Darkmode: lightgrey:
  Color accent(ThemeData theme) {
    return theme.brightness == Brightness.light
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF2E3538);
  }

  Color text(ThemeData theme) {
    return theme.brightness == Brightness.light
        ? const Color(0xFF2E3538)
        : const Color(0xFFFFFFFF);
  }

  Color disableSecondary(ThemeData theme) {
    return theme.brightness == Brightness.light
        ? Color.fromARGB(255, 254, 211, 82)
        : const Color.fromARGB(255, 170, 123, 41);
  }

  // Button contour:
  Color mainDisable(ThemeData theme) {
    return theme.brightness == Brightness.light
        ? const Color(0xFFffba3f)
        : const Color(0xFFFFFFFF).withOpacity(0.0);
  }

  Color greyIcon = const Color(0xFFCBD5E1);
  Color greyText = const Color(0xFF64748B);
  Color validate = const Color(0xFF03C923);
}

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, primaryColor: const Color(0xFF294F87));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, primaryColor: const Color(0xFF294F87));
