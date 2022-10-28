import 'package:flutter/material.dart';

class ThemeUtil {
  static const MaterialColor primaryColor = Colors.pink;
  static const secondaryColor = Colors.pink;
  static const primaryTextColor = Color(0xFF3b2b28);

  static ThemeData defaultTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: ThemeUtil.primaryColor,
      primaryColor: ThemeUtil.primaryColor,
      // https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(
        headline3: TextStyle(
          color: ThemeUtil.primaryColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        headline6: TextStyle(
          color: ThemeUtil.primaryTextColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        subtitle1: TextStyle(
            color: ThemeUtil.primaryTextColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins'),
        subtitle2: TextStyle(
          color: ThemeUtil.primaryTextColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w200,
        ),
        caption: TextStyle(
          color: ThemeUtil.primaryTextColor,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
