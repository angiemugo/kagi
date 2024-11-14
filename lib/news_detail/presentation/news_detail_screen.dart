import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/news_detail/widgets/webview.dart';
import 'package:kagi_task/news_detail/widgets/bullet_points_view.dart';
import 'package:kagi_task/news_detail/widgets/image_view.dart';
import 'package:kagi_task/news_detail/widgets/sources_view.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:kagi_task/util/kite_theme.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/timeline_section.dart';
import '../widgets/perspective_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailScreen extends StatelessWidget {
  final Cluster news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            _buildCategoryRow(context, news: news, l10n: l10n),
            _buildContentText(
              context,
              title: news.title,
              content: news.shortSummary,
            ),
            _buildImage(context, news: news),
            BulletPointsView(
              title: l10n.highlights_title,
              content: news.talkingPoints,
            ),
            _buildQuoteSection(context, news: news, l10n: l10n),
            PerspectiveView(
              title: l10n.perspectives_title,
              perspectives: news.perspectives,
            ),
            _buildContentText(
              context,
              title: l10n.humanitarian_impact_title,
              content: news.humanitarianImpact,
            ),
            BulletPointsView(
              title: l10n.scientific_significance_title,
              content: news.scientificSignificance,
            ),
            BulletPointsView(
              title: l10n.travel_advisory_title,
              content: news.travelAdvisory,
            ),
            TimelineSection(
              title: l10n.timeline_of_events_title,
              timeline: news.timeline,
            ),
            SourcesView(
              title: l10n.sources_title,
              domains: news.domains,
            ),
            _buildCard(
              content: BulletPointsView(
                title: l10n.action_items_title,
                content: news.userActionItems,
              ),
              color: actionGreen
            ),
            _buildCard(
              content: _buildContentText(
                context,
                title: l10n.did_you_know_title,
                content: news.didYouKnow,
              ),
              color: actionBlue,
            ),
            _shareNewsButton(context, l10n: l10n, news: news),
            _readArticleButton(context, l10n: l10n, news: news)
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context,
      {required Cluster news, required AppLocalizations l10n}) {
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
        Text(
          l10n.sources_count(news.articles.length),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context, {required Cluster news}) {
    final images = news.getImages();
    if (images.isEmpty) return const SizedBox.shrink();

    return ImageView(
      images: images,
      location: news.location,
    );
  }

  Widget _buildQuoteSection(BuildContext context,
      {required Cluster news, required AppLocalizations l10n}) {
    final decorations = Theme.of(context).extension<AppDecorations>();
    if (news.quote.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: decorations?.quoteBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.quote,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.quote_via(news.quoteAuthor, news.quoteSourceDomain),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blue,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentText(BuildContext context,
      {required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _shareNewsButton(BuildContext context,
      {required AppLocalizations l10n, required Cluster news}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            Share.shareUri(Uri.parse(news.articles.first.link));
          },
          icon: const Icon(Icons.share),
          label: Text(l10n.share_news_button),
        ),
      ),
    );
  }

  Widget _readArticleButton(BuildContext context,
      {required AppLocalizations l10n, required Cluster news}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Webview(link: news.articles.first.link),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward),
          label: Text(l10n.read_article_button),
          style: Theme.of(context).elevatedButtonTheme.style,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget content, Color? color}) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color ?? Colors.purple.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: content,
    );
  }
}
