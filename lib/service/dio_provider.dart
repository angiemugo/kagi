import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dioProvider(Ref ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://kite.kagi.com',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
  ));
  }