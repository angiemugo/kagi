import 'package:kagi_task/service/json_reader.dart';
import '../domain/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'articles_repository.g.dart';

class ArticlesRepository {
  final JsonReader _jsonReader;

  ArticlesRepository(this._jsonReader);

  Future<NewsModel> fetchNewsModel() async {
    return await _jsonReader.readModel(
        "assets/data/news.json", (json) => NewsModel.fromJson(json));
  }
}

@riverpod
Future<ArticlesRepository> articlesRepository(Ref ref) async {
  final jsonReader = ref.watch(jsonReaderProvider);
  return ArticlesRepository(jsonReader);
}
