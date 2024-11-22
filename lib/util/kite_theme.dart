import 'package:flutter/material.dart';

class KiteTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
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
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      extensions: [
        AppDecorations(
          quoteBox: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ],
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
      unselectedWidgetColor: Colors.grey,
      dividerColor: Colors.grey[700],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
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
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      extensions: [
        AppDecorations(
          quoteBox: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.grey[700]!,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ],
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
          color: Colors.white,
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
}
