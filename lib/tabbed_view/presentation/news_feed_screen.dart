import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/presentation/news_detail_screen.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';
import '../domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({
    super.key,
    required this.clusters,
    required this.date,
    required this.categories,
  });

  final List<Cluster> clusters;
  final String date;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: clusters.length + 1,
        separatorBuilder: (_, __) => Divider(
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
        itemBuilder: (context, index) {
          if (index == 0) return _buildListTitle(context);
          final cluster = clusters[index - 1];
          return _buildClusterTile(context, cluster);
        },
      ),
    );
  }

  Widget _buildListTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          const Icon(Icons.menu, size: 16),
          const SizedBox(width: 6),
          const Icon(Icons.menu_book_sharp, size: 16),
        ],
      ),
    );
  }

  Widget _buildClusterTile(BuildContext context, Cluster cluster) {
    return ListTile(
      dense: true,
      onTap: () => _navigateToDetailScreen(context, cluster),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTileHeader(context, cluster),
          const SizedBox(height: 8.0),
          Text(
            cluster.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, Cluster cluster) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsDetailScreen(news: cluster),
      ),
    );
  }

  Widget _buildTileHeader(BuildContext context, Cluster cluster) {
    final l10n = AppLocalizations.of(context)!;
    final category =
        categories.firstWhere((cat) => cat.name == cluster.category);

    return Row(
      children: [
        _buildCategoryTag(context, category),
        const SizedBox(width: 8),
        const Icon(Icons.layers, size: 12, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          l10n.sources_count(cluster.articles.length),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        _buildActionIcons(),
      ],
    );
  }

  Widget _buildCategoryTag(BuildContext context, Category category) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: category.color),
        children: [
          const TextSpan(text: "• "),
          TextSpan(text: category.name),
        ],
      ),
    );
  }

  Widget _buildActionIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(Icons.share, "Clicked on Share"),
        const SizedBox(width: 12),
        _buildIconButton(Icons.check_circle, "Clicked on Select"),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String debugMessage) {
    return InkWell(
      onTap: () => debugPrint(debugMessage),
      child: Icon(
        icon,
        size: 14,
        color: Colors.grey[500],
      ),
    );
  }
}
