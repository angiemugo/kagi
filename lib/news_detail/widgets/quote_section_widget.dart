import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/widgets/web_button.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:kagi_task/util/app_decorations.dart';
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
          _buildIcon(),
          const SizedBox(height: 8),
          _buildQuoteText(context),
          const SizedBox(height: 8),
          _buildQuoteAuthor(context, quoteSource),
          const SizedBox(height: 8),
          WebButton(
            name: news.quoteSourceDomain,
            url: news.quoteSourceUrl,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return const Icon(Icons.format_quote, size: 48);
  }

  Widget _buildQuoteText(BuildContext context) {
    return Text(
      news.quote,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildQuoteAuthor(BuildContext context, Map<String, String>? quoteSource) {
    final title = quoteSource?["title"] ?? "";
    final content = quoteSource?["content"] ?? "";

    return Text(
      "$title\n$content",
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Colors.black.withOpacity(0.4)),
      textAlign: TextAlign.start,
    );
  }
}
