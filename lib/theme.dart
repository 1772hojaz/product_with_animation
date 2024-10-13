import 'package:flutter/material.dart';

class AppTheme {
  //Primary color for both themes

  static const Color primaryColorLight = Colors.orange;
  static const Color primaryColorDark = Color.fromARGB(255, 75, 10, 10);

  // Light theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColorLight,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: primaryColorLight,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: primaryColorLight),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColorDark,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: primaryColorDark,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(primary: primaryColorDark),
  );
}
