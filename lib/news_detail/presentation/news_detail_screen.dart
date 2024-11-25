import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/news_detail/widgets/highlights_view.dart';
import 'package:kagi_task/news_detail/widgets/international_reactions.dart';
import 'package:kagi_task/news_detail/widgets/quote_section.dart';
import 'package:kagi_task/news_detail/widgets/webview.dart';
import 'package:kagi_task/news_detail/widgets/bullet_points_view.dart';
import 'package:kagi_task/news_detail/widgets/scrollable_page_view.dart';
import 'package:kagi_task/news_detail/widgets/sources_view.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/timeline_section.dart';
import '../widgets/perspective_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetailScreen extends ConsumerWidget {
  final Cluster news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final images = news.getImages();

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
            _buildTitleRow(ref, context, news: news, l10n: l10n),
            _buildContentText(context,
                title: news.title, content: news.shortSummary),
            if (images.isNotEmpty)
              _buildScrollableItems(context, images: images),
            HighlightsView(
              title: l10n.highlights_title,
              content: news.talkingPoints,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (news.quote.isNotEmpty) QuoteSectionWidget(news: news),
            const SizedBox(
              height: 16,
            ),
            if (images.length < 2) _buildImageView(images.last),
            PerspectiveView(
              title: l10n.perspectives_title,
              perspectives: news.perspectives,
            ),
            _buildContentText(context,
                title: l10n.geopolitical_context_title,
                content: news.geopoliticalContext),
            _buildContentText(context,
                title: l10n.historical_background_title,
                content: news.historicalBackground),
            InternationalReactionsView(reactions: news.internationalReactions),
            _buildContentText(context,
                title: l10n.economic_implications_title,
                content: news.economicImplications),
            _buildContentText(context,
                title: l10n.humanitarian_impact_title,
                content: news.humanitarianImpact),
            BulletPointsView(
              title: l10n.scientific_significance_title,
              content: news.scientificSignificance,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            BulletPointsView(
              title: l10n.travel_advisory_title,
              content: news.travelAdvisory,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TimelineSection(
                title: l10n.timeline_of_events_title, timeline: news.timeline),
            SourcesView(title: l10n.sources_title, domains: news.domains),
            _buildContentText(context,
                title: l10n.future_outlook_title, content: news.futureOutlook),
            _buildActionCards(l10n, context),
            _shareNewsButton(context, l10n: l10n, news: news),
            _readArticleButton(context, l10n: l10n, news: news),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(WidgetRef ref, BuildContext context,
      {required Cluster news, required AppLocalizations l10n}) {
    final categories =
        ref.read(tabbedNewsControllerProvider.notifier).categories;
    final category =
        categories.firstWhere((element) => element.name == news.category);

    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: category.color),
            children: [
              const TextSpan(text: "• ", style: TextStyle(fontSize: 12)),
              TextSpan(text: category.name),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.layers, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          l10n.sources_count(news.articles.length),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildImageView(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.error, color: Colors.red, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableItems(BuildContext context,
      {required List<String> images}) {
    final imageViews = images.map((e) => _buildImageView(e)).toList();
    return ScrollablePageView(views: imageViews, location: news.location);
  }

  Widget _buildContentText(BuildContext context,
      {required String title, required String content}) {
    if (title.isEmpty || content.isEmpty) {
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
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildActionCards(AppLocalizations l10n, BuildContext context) {
    return Column(
      children: [
        _buildCard(
          content: BulletPointsView(
            title: l10n.action_items_title,
            content: news.userActionItems,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
          color: actionGreen,
        ),
        _buildCard(
          content: _buildContentText(context,
              title: l10n.did_you_know_title, content: news.didYouKnow),
          color: actionBlue,
        ),
      ],
    );
  }

  Widget _shareNewsButton(BuildContext context,
      {required AppLocalizations l10n, required Cluster news}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => Share.shareUri(Uri.parse(news.articles.first.link)),
          label: Text(l10n.share_news_button),
          icon: const Icon(
            Icons.share,
          ),
        ),
      ),
    );
  }

  Widget _readArticleButton(BuildContext context,
      {required AppLocalizations l10n, required Cluster news}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showWebview(context, news.articles.first.link),
          label: Text(l10n.read_article_button),
          icon: const Icon(
            Icons.arrow_forward,
          ),
          iconAlignment: IconAlignment.end,
        ),
      ),
    );
  }

  void _showWebview(BuildContext context, String url) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Webview(link: url)));
  }

  Widget _buildCard({required Widget content, Color? color}) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
      decoration: BoxDecoration(
        color: color ?? Colors.purple.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: content,
    );
  }
}
