import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine(
      {super.key,
      this.height = 1,
      this.color = Colors.grey,
      this.padding = const EdgeInsets.symmetric(vertical: 8.0)});
  final double height;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(
          padding: padding,
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(
              dashCount,
              (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
