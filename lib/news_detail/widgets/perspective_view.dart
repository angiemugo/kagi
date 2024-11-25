import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/news_detail/widgets/web_button.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:kagi_task/util/string_splitter.dart';
import '../../util/kite_theme.dart';

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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: perspectives.map((perspective) {
                final perspectiveText = perspective.text.splitOrExtract();
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildPerspectiveCard(
                    context,
                    title: perspectiveText?["title"] ?? "",
                    description: perspectiveText?["content"] ?? "",
                    width: cardWidth,
                    domains: perspective.sources,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerspectiveCard(
    BuildContext context, {
    required String title,
    required String description,
    required double width,
    required List<Source> domains,
  }) {
    final decorations = Theme.of(context).extension<AppDecorations>();

    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.all(12.0),
      decoration: decorations?.quoteBox?.copyWith(color: actionGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, 
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: domains.map((url) {
              return WebButton(url: url.name);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
