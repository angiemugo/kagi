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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          const DashedLine(),
          const SizedBox(height: 8),
          ..._buildNumberedPoints(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: style?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  List<Widget> _buildNumberedPoints() {
    return content.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final point = entry.value;
        return _NumberedPoint(
          index: index,
          text: point,
          style: style,
        );
      },
    ).toList();
  }
}

class _NumberedPoint extends StatelessWidget {
  final int index;
  final String text;
  final TextStyle? style;

  const _NumberedPoint({
    required this.index,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final pointParts = text.splitOrExtract();
    final title = pointParts?['title'] ?? '';
    final content = pointParts?['content'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCircleNumber(),
              const SizedBox(width: 8),
              if (title.isNotEmpty)
                Expanded(
                  child: Text(
                    title,
                    style: style?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (content.isNotEmpty)
            Text(
              content,
              style: style,
            ),
          const SizedBox(height: 8),
          const DashedLine(),
        ],
      ),
    );
  }

  Widget _buildCircleNumber() {
    return Container(
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
    );
  }
}
