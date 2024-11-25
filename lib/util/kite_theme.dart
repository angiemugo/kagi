import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';

class KiteTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
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
          backgroundColor: Colors.black,
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
          fontSize: 24,
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

class AppDecorations extends ThemeExtension<AppDecorations> {
  final BoxDecoration? quoteBox;

  const AppDecorations({this.quoteBox});

  @override
  AppDecorations copyWith({BoxDecoration? quoteBox}) {
    return AppDecorations(quoteBox: quoteBox ?? this.quoteBox);
  }

  @override
  AppDecorations lerp(ThemeExtension<AppDecorations>? other, double t) {
    if (other is! AppDecorations) return this;
    return AppDecorations(
      quoteBox: BoxDecoration.lerp(quoteBox, other.quoteBox, t),
    );
  }

  static final AppDecorations light = AppDecorations(
    quoteBox: BoxDecoration(
      color: quoteBlue,
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final AppDecorations dark = AppDecorations(
    quoteBox: BoxDecoration(
      color: quoteBlue,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
