import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/tabbed_view/presentation/drawer_view.dart';
import 'package:kagi_task/tabbed_view/presentation/news_feed_screen.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';
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
        drawer: DrawerView(sections: drawerSections),
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
}
