import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xff5D9CEC); // need to edit primary
  static const black = Color(0xff141922);
  // static const blackNavi = Color(0xff141922);
  static const whiteColor = Color(0xffFFFFFF);
  static const greyColor = Color.fromARGB(255, 77, 76, 76);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: whiteColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 28,
      backgroundColor: primary,
      elevation: 0,
      foregroundColor: whiteColor,
      shape: CircleBorder(side: BorderSide(color: whiteColor, width: 0)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: greyColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: whiteColor,
      centerTitle: true,
    ),
  );
}
