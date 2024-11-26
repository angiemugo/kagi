import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/const/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:kagi_task/tabbed_view/presentation/drawer_view.dart';
import 'package:kagi_task/tabbed_view/presentation/dropdown_view.dart';
import 'package:kagi_task/tabbed_view/presentation/news_feed_screen.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';
import '../domain/news_model.dart';

class TabbedNewsScreen extends ConsumerWidget {
  const TabbedNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tabbedNewsController = ref.watch(tabbedNewsControllerProvider);

    return tabbedNewsController.when(
      data: (newsModel) => _buildTabbedNewsView(context, ref, newsModel),
      error: (error, stackTrace) => _buildErrorView(context, l10n, error),
      loading: () => _buildLoadingView(),
    );
  }

  Widget _buildErrorView(BuildContext context, AppLocalizations l10n, Object error) {
    return Center(
      child: Text(
        l10n.error_text(error.toString()),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTabbedNewsView(
    BuildContext context,
    WidgetRef ref,
    NewsModel newsModel,
  ) {
    final tabController = ref.read(tabbedNewsControllerProvider.notifier);
    final categories = tabController.categories;
    final timestamp = tabController.getTimestamp(newsModel.timestamp);
    final settings = tabController.generalSettings;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: _buildAppBar(context, categories),
        drawer: DrawerView(settings: settings, categories: categories),
        body: _buildTabBarView(ref, newsModel, categories, timestamp),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, List<Category> categories) {
    return AppBar(
      leading: _buildLeadingIcon(context),
      actions: [_buildSettingsIcon(context)],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildDropdown(categories),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return Builder(
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
           Text(
              'Kite',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add settings action here
      },
      icon: const Icon(Icons.settings),
    );
  }

  Widget _buildDropdown(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: DropdownView(categories: categories),
        ),
      ),
    );
  }

  Widget _buildTabBarView(
    WidgetRef ref,
    NewsModel newsModel,
    List<Category> categories,
    String timestamp,
  ) {
    return TabBarView(
      children: categories.map((category) {
        return _buildTabContent(ref, category, newsModel, categories, timestamp);
      }).toList(),
    );
  }

  Widget _buildTabContent(
    WidgetRef ref,
    Category category,
    NewsModel newsModel,
    List<Category> categories,
    String timestamp,
  ) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final tabData = selectedCategory.name == "World"
        ? newsModel.clusters
        : ref.read(tabbedNewsControllerProvider.notifier).getCategory(selectedCategory);

    return NewsFeedScreen(
      clusters: tabData,
      date: timestamp,
      categories: categories,
    );
  }
}
