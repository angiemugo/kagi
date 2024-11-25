import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/news_detail/widgets/dashed_lines.dart';
import 'package:kagi_task/util/string_splitter.dart';

class HighlightsView extends StatelessWidget {
  final String title;
  final List<String> content;
  final TextStyle? style;

  const HighlightsView({
    super.key,
    required this.title,
    required this.content,
    required this.style,
  });

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
          Text(
            title,
            style: style?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          const DashedLine(),
          const SizedBox(height: 8),
          ...content.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final point = entry.value;
              return buildNumberedPoint(
                index: index,
                text: point,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildNumberedPoint({required int index, required String text}) {
    final pointTitle = text.splitOrExtract();
    final title = pointTitle!['title']!;
    final content = pointTitle['content']!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: actionOrange,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: style?.copyWith(color: Colors.black, fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            if (title.isNotEmpty)
              Text(
                title,
                style: style?.copyWith(fontWeight: FontWeight.bold),
              ),
          ]),
          const SizedBox(
            height: 8,
          ),
          if (content.isNotEmpty)
            Text(
              content,
              style: style,
            ),
          const DashedLine()
        ],
      ),
    );
  }
}
