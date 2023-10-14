import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
}
