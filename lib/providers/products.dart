import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product.dart';
import '../services.dart';

part 'products.g.dart';

@riverpod
Future<List<Product>> products(ProductsRef ref) async {
  final response = await ref.watch(dioProvider).get('/products');

  return (response.data['products'] as List)
      .cast<Map<String, Object?>>()
      .map(Product.fromJson)
      .toList();
}

@riverpod
Future<Product> product(ProductRef ref, {required int id}) async {
  final response = await ref.watch(dioProvider).get('/products/$id');

  return Product.fromJson(response.data);
}
