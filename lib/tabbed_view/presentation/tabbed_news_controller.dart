import 'package:kagi_task/tabbed_view/data/articles_repository.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:math';

part 'tabbed_news_controller.g.dart';

class Category {
  final String name;
  final Color color;

  Category({required this.name, required this.color});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

@riverpod
class TabbedNewsController extends _$TabbedNewsController {
  Map<Category, List<Cluster>> _clusters = {};
  List<Category> _categories = [];
  int _currentTabIndex = 0;

  final List<Color> predefinedColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
  ];

  @override
  Future<NewsModel> build() async {
    try {
      final articleRepo = await ref.watch(articlesRepositoryProvider.future);
      final response = await articleRepo.fetchNewsModel();
      _clusters = _groupByCategory(response);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  List<Color> availableColors = [];

  Color _getRandomColor() {
    if (availableColors.isEmpty) {
      availableColors = List.from(predefinedColors);
    }

    Random random = Random();
    if (availableColors.isNotEmpty) {
      final color =
          availableColors.removeAt(random.nextInt(availableColors.length));
      return color;
    } else {
      return Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      );
    }
  }

  Map<Category, List<Cluster>> _groupByCategory(NewsModel newsModel) {
    final Map<Category, List<Cluster>> grouped = {};

    for (var cluster in newsModel.clusters) {
      var category = grouped.keys.firstWhere(
        (existingCategory) => existingCategory.name == cluster.category,
        orElse: () =>
            Category(name: cluster.category, color: _getRandomColor()),
      );

      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }

      grouped[category]!.add(cluster);
    }

    _categories = [
      Category(name: "World", color: Colors.black),
      ...grouped.keys,
    ];

    return grouped;
  }

  List<Cluster> getCategory(Category category) {
    if (category.name == "World") {
      return _clusters.values.expand((e) => e).toList();
    }
    return _clusters[category] ?? [];
  }

  String getTimestamp(int timestamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    String formattedDate = DateFormat('EEE, dd MMM yyyy').format(date);

    return formattedDate;
  }

  List<Map<String, dynamic>> getDrawerSections(NewsModel newsModel) {
    final generalItems = ["Account", "Settings", "Interest", "Order"];

    return [
      {"title": "General", "data": generalItems},
      {"title": "", "data": categories.map((c) => c.name).toList()}
    ];
  }

  int get currentTabIndex => _currentTabIndex;

  List<Category> get categories => _categories;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    state = AsyncValue.data(state.value!);
  }
}
