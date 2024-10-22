import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      elevation: 0,
      titleTextStyle: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.w500),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16, fontFamily: 'Roboto'),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: 'Roboto'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue),
      ),
      labelStyle: TextStyle(fontFamily: 'Roboto'),
      hintStyle: TextStyle(fontFamily: 'Roboto'),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.blueGrey[800],
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[800],
      elevation: 0,
      titleTextStyle: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Roboto'),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Roboto'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey[600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueGrey[300],
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blueGrey[300],
        side: BorderSide(color: Colors.blueGrey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blueGrey[400]!),
      ),
      labelStyle: TextStyle(fontFamily: 'Roboto', color: Colors.white70),
      hintStyle: TextStyle(fontFamily: 'Roboto', color: Colors.white70),
    ),
  );
}
