import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    required String brand,
    required String category,
    required String thumbnail,
    required List<String> images,
  }) = _Product;

  bool get hasDiscount => discountPercentage > 0;
  double get discountedPrice => (100 - discountPercentage) * price / 100;

  const Product._();

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
