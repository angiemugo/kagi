import 'package:flutter/material.dart';


extension BulletPointTextSpan on String {
  TextSpan toBulletPointTextSpan({double fontSize = 12}) {
    return TextSpan(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
      children: [
        const TextSpan(text: "• ", style: TextStyle(fontSize: 12)),
        TextSpan(text: this),
      ],
    );
  }
}
