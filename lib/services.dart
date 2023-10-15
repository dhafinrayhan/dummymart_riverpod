import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/user.dart';

part 'services.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio()..options.baseUrl = 'https://dummyjson.com';

  final token = ref.watch(tokenProvider);
  if (token != null) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  return dio;
}

@Riverpod(keepAlive: true)
String? token(TokenRef ref) {
  return ref.watch(currentUserProvider.select((user) => user?.token));
}

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final token = ref.watch(tokenProvider);
  return token != null;
}

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() => null;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await ref.read(dioProvider).post('/auth/login', data: {
      'username': username,
      'password': password,
    });

    state = User.fromJson(response.data);
  }

  Future<void> logout() async {
    state = null;
  }
}
