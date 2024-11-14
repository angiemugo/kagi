import 'package:flutter/material.dart';
import 'package:kagi_task/domain/news_model.dart';
import 'kite_theme.dart';

class PerspectiveView extends StatelessWidget {
  final List<Perspective> perspectives;
  final String title;

  const PerspectiveView({
    super.key,
    required this.title,
    required this.perspectives,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.5;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: perspectives.length,
              itemBuilder: (context, index) {
                final perspective = perspectives[index];
                final perspectiveText = splitText(perspective.text);
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 0.0 : 8.0, right: 8.0, bottom: 8.0),
                  child: _buildPerspectiveCard(
                      title: perspectiveText["title"] ?? "",
                      description: perspectiveText["description"] ?? "",
                      width: cardWidth,
                      context: context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerspectiveCard({
    required String title,
    required String description,
    required double width,
    required BuildContext context,
  }) {
    final decorations = Theme.of(context).extension<AppDecorations>();

    return Container(
      width: width,
      padding: const EdgeInsets.all(12.0),
      decoration: decorations?.quoteBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ).copyWith(
              fontSize: title.length > 20 ? 12 : 14,
              letterSpacing: title.length > 20 ? -0.5 : 0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
          ),
        ],
      ),
    );
  }

  Map<String, String> splitText(String text) {
    final parts = text.split(':');

    if (parts.length >= 2) {
      return {
        'title': parts[0].trim(),
        'description': parts.sublist(1).join(':').trim(),
      };
    }

    return {
      'title': '',
      'description': '',
    };
  }
}
