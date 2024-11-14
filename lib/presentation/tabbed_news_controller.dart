import 'package:kagi_task/data/articles_repository.dart';
import 'package:kagi_task/domain/news_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'tabbed_news_controller.g.dart';

@riverpod
class TabbedNewsController extends _$TabbedNewsController {
  Map<String, List<Cluster>> _clusters = {};
  List<String> _categories = [];
  int _currentTabIndex = 0;

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

  Map<String, List<Cluster>> _groupByCategory(NewsModel newsModel) {
    final Map<String, List<Cluster>> grouped = {};
    for (var cluster in newsModel.clusters) {
      grouped.putIfAbsent(cluster.category, () => []).add(cluster);
    }
    _categories = ["All", ...grouped.keys];
    return grouped;
  }

  List<Cluster> getCategory(String category) {
    if (category == "All") return _clusters.values.expand((e) => e).toList();
    return _clusters[category] ?? [];
  }

  String getTimestamp(int timestamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    String formattedDate = DateFormat('EEE, dd MMM yyyy').format(date);

    return formattedDate;
  }

  List<Map<String, dynamic>> getDrawerSections(NewsModel newsModel) {
    final generalItems = ["Account", "Settings", "Interest", "Preferences"];

    return [
      {"title": "General", "data": generalItems},
      {"title": "More Options", "data": categories}
    ];
  }

  int get currentTabIndex => _currentTabIndex;
  List<String> get categories => _categories;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    state = AsyncValue.data(state.value!);
  }
}
