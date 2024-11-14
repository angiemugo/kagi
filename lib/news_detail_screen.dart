import 'package:flutter/material.dart';
import 'package:kagi_task/image_view.dart';
import 'package:kagi_task/sources_view.dart';
import 'package:share_plus/share_plus.dart';
import 'timeline_section.dart';
import 'perspective_view.dart';
import 'domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'kite_theme.dart';

class NewsDetailScreen extends StatefulWidget {
  final Cluster newsItem;

  const NewsDetailScreen({super.key, required this.newsItem});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final news = widget.newsItem;

    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(news.category),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryRow(news, l10n),
            _buildContentText(title: news.title, content: news.shortSummary),
            _buildImage(news),
            _buildBulletPoints(
                title: l10n.highlights_title, bulletPoints: news.talkingPoints),
            _buildQuoteSection(news, l10n),
            PerspectiveView(
                title: l10n.perspectives_title,
                perspectives: news.perspectives),
            _buildContentText(
                title: l10n.humanitarian_impact_title,
                content: news.humanitarianImpact),
            _buildBulletPoints(
                title: l10n.scientific_significance_title,
                bulletPoints: news.scientificSignificance),
            _buildBulletPoints(
                title: l10n.scientific_significance_title,
                bulletPoints: news.travelAdvisory),
            TimelineSection(
                title: l10n.timeline_of_events_title, timeline: news.timeline),
            SourcesView(title: l10n.sources_title, domains: news.domains),
            _buildCard(
              content: _buildBulletPoints(
                  title: l10n.action_items_title,
                  bulletPoints: news.userActionItems),
              color: const Color.fromRGBO(241, 251, 231, 1.0),
            ),
            _buildCard(
                content: _buildContentText(
                    title: l10n.did_you_know_title, content: news.didYouKnow),
                color: const Color.fromRGBO(206, 216, 251, 1.0)),
            _shareNewsButton(l10n),
            _readArticleButton(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(Cluster news, AppLocalizations l10n) {
    return Row(
      children: [
        Text(news.category, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 16),
        const Icon(
          Icons.layers,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(l10n.sources_count(news.articles.length),
            style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  Widget _buildImage(Cluster news) {
    final images = news.getImages();

    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return ImageView(images: images, location: news.location);
  }

  Widget _buildQuoteSection(Cluster news, AppLocalizations l10n) {
    final decorations = Theme.of(context).extension<AppDecorations>();

    if (news.quote.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: decorations?.quoteBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(news.quote,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Text(l10n.quote_via(news.quoteAuthor, news.quoteSourceDomain),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildContentText({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
          const SizedBox(
            height: 16,
          ),
          Text(content, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black))
        ],
      ),
    );
  }

  Widget _buildBulletPoints({
    required String title,
    required List<String> bulletPoints,
  }) {
    if (bulletPoints.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
          ...bulletPoints.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "• ",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
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

  Widget _shareNewsButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            Share.shareUri(Uri.parse("https://tass.com/world/1870247"));
          },
          icon: const Icon(Icons.share),
          label: Text(l10n.share_news_button),
        ),
      ),
    );
  }

  Widget _readArticleButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
            iconAlignment: IconAlignment.end,
            onPressed: () {
              // Add read article action here
            },
            icon: const Icon(Icons.arrow_forward),
            label: Text(l10n.read_article_button),
            style: Theme.of(context).elevatedButtonTheme.style),
      ),
    );
  }

  Widget _buildCard({required Widget content, Color? color}) {
    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: color ?? Colors.purple.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: content);
  }
}
