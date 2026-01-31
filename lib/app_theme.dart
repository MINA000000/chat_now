import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xff5D9CEC); // need to edit primary
  static const black = Color(0xff363636);
  static const blackNavi = Color(0xff141922);
  static const whiteColor = Color(0xffFFFFFF);
  static const grey = Color(0xffC8C9CB);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: whiteColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 0,
      foregroundColor: whiteColor,
      shape: CircleBorder(side: BorderSide(color: whiteColor, width: 4)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        // fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
  );
}
