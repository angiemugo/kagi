import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/util/app_decorations.dart';

class KiteTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: actionGrey,
        surface: Colors.grey,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      unselectedWidgetColor: Colors.grey,
      dividerColor: Colors.grey[400],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      extensions: [AppDecorations.light],
      textTheme: TextTheme(
        headlineLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleMedium: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        bodySmall: TextStyle(fontSize: 12, color: Colors.grey[600]),
        labelMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: Colors.blue,
        secondary: actionGreyDark,
        surface: Colors.grey[900] ?? Colors.black,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      unselectedWidgetColor: Colors.grey,
      dividerColor: Colors.grey[700],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      extensions: [AppDecorations.dark],
      textTheme: TextTheme(
        headlineLarge: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        bodySmall: TextStyle(fontSize: 12, color: Colors.grey[500]),
        labelMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
