import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.height = 1.0,
    this.color = Colors.grey,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.dashWidth = 2.0,
    this.spacing = 2.0,
  });

  final double height;
  final Color color;
  final EdgeInsets padding;
  final double dashWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + spacing)).floor();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              dashCount,
              (_) => SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
