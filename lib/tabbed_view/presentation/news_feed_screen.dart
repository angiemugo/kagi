import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/presentation/news_detail_screen.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';
import '../domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen(
      {super.key,
      required this.clusters,
      required this.date,
      required this.categories});

  final List<Cluster> clusters;
  final String date;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: clusters.length + 1,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        itemBuilder: (context, index) {
          if (index == 0) return _buildListTitle();
          final cluster = clusters[index - 1];
          return ListTile(
              dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(news: cluster),
                  ),
                );
              },
              title: _buildListTile(context, cluster: cluster));
        },
      ),
    );
  }

  Widget _buildListTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(date),
          const Spacer(),
          const Icon(
            Icons.menu,
            size: 16,
          ),
          const SizedBox(
            width: 6,
          ),
          const Icon(
            Icons.menu_book_sharp,
            size: 16,
          )
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required Cluster cluster}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTileTitle(context, cluster: cluster),
        Text(
          cluster.title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTileTitle(BuildContext context, {required Cluster cluster}) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final category =
        categories.firstWhere((element) => element.name == cluster.category);

    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: category.color),
            children: [
              const TextSpan(
                  text: "• ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              TextSpan(
                text: category.name,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.layers,
          size: 16,
          color: Colors.grey,
        ),
        Text(l10n.sources_count(cluster.articles.length),
            style: Theme.of(context).textTheme.bodySmall),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => print("typed"),
              child: Icon(
                Icons.share,
                size: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(width: 12,),
            InkWell(
              onTap: () => print("typed"),
              child: Icon(
                Icons.check_circle,
                size: 14,
                color: Colors.grey[500],
              ),
            )
          ],
        ),
      ],
    );
  }
}
