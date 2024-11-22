import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/const/images.dart';
import 'package:kagi_task/tabbed_view/presentation/drawer_view.dart';
import 'package:kagi_task/tabbed_view/presentation/dropdown_view.dart';
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
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    kiteIcon,
                    width: 14,
                    height: 14,
                  ),
                  const Text(
                    'Kite',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Add your action here
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DropdownView(
                    categories: categories,
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: DrawerView(sections: drawerSections),
        body: TabBarView(
          children: categories.map((category) {
            final selectedCategory = ref.watch(selectedCategoryProvider);

            final tabData = selectedCategory.name == "World"
                ? newsModel.clusters
                : tabController.getCategory(selectedCategory);
            return NewsFeedScreen(
              clusters: tabData,
              date: timestamp,
              categories: categories,
            );
          }).toList(),
        ),
      ),
    );
  }
}
