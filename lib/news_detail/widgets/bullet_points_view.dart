import 'package:flutter/material.dart';

class BulletPointsView extends StatelessWidget {
  final String title;
  final List<String> content;
  final TextStyle? style;

  const BulletPointsView(
      {super.key, required this.title, required this.content, required this.style});

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: style?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...content.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: RichText(
                text: TextSpan(
                  style: style,
                  children: [
                    TextSpan(
                        text: "• ",
                        style: style?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: point,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
