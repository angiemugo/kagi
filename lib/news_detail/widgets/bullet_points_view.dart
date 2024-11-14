import 'package:flutter/material.dart';

class BulletPointsView extends StatelessWidget {
  final String title;
  final List<String> content;

  const BulletPointsView(
      {super.key, required this.title, required this.content});
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
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
          ...content.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "• ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black)),
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
