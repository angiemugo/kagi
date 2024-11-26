import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';

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
      color: quoteBlueDark,
      borderRadius: BorderRadius.circular(8),
 
    ),
  );
}
