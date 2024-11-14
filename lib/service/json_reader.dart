import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'json_reader.g.dart';

@riverpod
JsonReader jsonReader(Ref ref) {
  return JsonReader();
}

class JsonReader {
  Future<T> readModel<T>(
      String path, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final String jsonString = await rootBundle.loadString(path);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return fromJson(jsonMap);
    } catch (e) {
      throw Exception("Failed to read JSON: $e");
    }
  }
}
