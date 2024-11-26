import 'package:flutter/material.dart';

class BulletPointsView extends StatelessWidget {
  final String title;
  final List<String> content;
  final TextStyle? style;

  const BulletPointsView({
    super.key,
    required this.title,
    required this.content,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: style?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...content.map(
            (point) => _buildBulletPoint(point),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: style?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
