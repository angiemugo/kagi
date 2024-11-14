import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/news_feed_screen.dart';
import 'package:kagi_task/presentation/tabbed_news_controller.dart';
import '../domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabbedNewsScreen extends ConsumerWidget {
  const TabbedNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final tabbedNewsController = ref.watch(tabbedNewsControllerProvider);
    return tabbedNewsController.when(
        data: (newsModel) => _buildTabbedNewsView(context, ref, newsModel),
        error: (error, stackTrace) => Center(
            child: Text(l10n.error_text(error.toString()),
                style: Theme.of(context).textTheme.titleMedium)),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  Widget _buildTabbedNewsView(
      BuildContext context, WidgetRef ref, NewsModel newsModel) {
    final tabController = ref.read(tabbedNewsControllerProvider.notifier);
    final categories = tabController.categories;
    final timestamp = tabController.getTimestamp(newsModel.timestamp);
    final drawerSections = tabController.getDrawerSections(newsModel);

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(timestamp),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((category) => Tab(text: category)).toList(),
            onTap: (index) => tabController.setTabIndex(index)
          ),
        ),
        drawer: _buildDrawer(drawerSections, context),
        body: TabBarView(
          children: categories.map((category) {
            final tabData = category == "All"
                ? newsModel.clusters
                : tabController.getCategory(category);
            return NewsFeedScreen(clusters: tabData);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDrawer(
      List<Map<String, dynamic>> sections, BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, sectionIndex) {
          final section = sections[sectionIndex];
          final sectionTitle = section['title'] as String;
          final sectionItems = section['data'] as List<dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sectionItems.length,
                separatorBuilder: (context, index) =>
                    const Divider(indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final item = sectionItems[index];
                  return ListTile(
                    dense: true,
                    title: Text(item.toString()),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
