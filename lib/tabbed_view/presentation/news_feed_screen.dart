import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/presentation/news_detail_screen.dart';
import '../domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key, required this.clusters});

  final List<Cluster> clusters;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
        body: ListView.separated(
      itemCount: clusters.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      itemBuilder: (context, index) {
        final cluster = clusters[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailScreen(news: cluster),
              ),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(cluster.category,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.layers,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(l10n.sources_count(cluster.articles.length),
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
              const SizedBox(height: 4),
              Text(
                cluster.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
