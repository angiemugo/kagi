import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/widgets/web_button.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:kagi_task/util/kite_theme.dart';
import 'package:kagi_task/util/string_splitter.dart';

class QuoteSectionWidget extends StatelessWidget {
  final Cluster news;

  const QuoteSectionWidget({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final decorations = Theme.of(context).extension<AppDecorations>();
    final quoteSource = news.quoteAuthor.splitOrExtract(delimiter: ",");

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: decorations?.quoteBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, size: 48),
          const SizedBox(height: 8),
          Text(news.quote, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(
            "${quoteSource?["title"]}\n${quoteSource?["content"]}",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black.withOpacity(0.4)),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          WebButton(url: news.quoteSourceDomain),
        ],
      ),
    );
  }
}
