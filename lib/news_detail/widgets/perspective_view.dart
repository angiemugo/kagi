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

    if (perspectives.isEmpty) {
      return const SizedBox.shrink();
    }

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
                final perspectiveText = perspective.text.splitOrExtract();

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0.0 : 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: _buildPerspectiveCard(
                    context,
                    title: perspectiveText?["title"] ?? "",
                    description: perspectiveText?["content"] ?? "",
                    width: cardWidth,
                    domains: perspective.sources,
                  ),
                );
              },
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
      padding: const EdgeInsets.all(12.0),
      decoration: decorations?.quoteBox?.copyWith(color: actionGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ).copyWith(
              fontSize: title.length > 20 ? 12 : 14,
              letterSpacing: title.length > 20 ? -0.5 : 0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: domains.map((url) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: WebButton(url: url.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
