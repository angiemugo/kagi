import 'package:kagi_task/service/dio_provider.dart';

import '../domain/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'articles_repository.g.dart';

class ArticlesRepository {
  final Dio dio;

  ArticlesRepository({required this.dio});

  Future<NewsModel> fetchNewsModel() async {
    try {
      final response = await dio.get('/world.json');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return NewsModel.fromJson(data);
        } else {
          throw Exception('Unexpected response format: Expected a JSON object.');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

@riverpod
Future<ArticlesRepository> articlesRepository(Ref ref) async {
  final dio = ref.watch(dioProviderProvider);
  return ArticlesRepository(dio: dio);
}
