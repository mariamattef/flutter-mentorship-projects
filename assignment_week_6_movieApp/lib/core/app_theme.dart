import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF44BDB6);
  static const Color secondaryColor = Color(0xffE1F8F9);
  static const Color errorColor = Colors.redAccent;
  static const textColor = Color(0xff8F8F8F);
  static const lightGray = Color(0xffF5F5F5);
  static const textColor1 = Color(0xff1D1E20);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      fontFamily: 'ZalandoSansSemiExpanded',
      appBarTheme: const AppBarTheme(
        backgroundColor: secondaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor1),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'ZalandoSansSemiExpanded',
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(31, 54, 53, 53),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
