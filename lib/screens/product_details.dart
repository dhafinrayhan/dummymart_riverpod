import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/products.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(id: id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: product.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(
          child: Text('An error occured'),
        ),
        data: (product) => ListView(
          children: [
            ImageSlideshow(
              height: 200,
              isLoop: true,
              children: [
                for (final image in product.images)
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  )
              ],
            ),
            const Gap(20),
            PaddedColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              padding: const EdgeInsets.all(8),
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Row(
                  children: [
                    Text('${product.rating}'),
                    const Gap(2),
                    Icon(Icons.star, size: 14, color: Colors.yellow[800]),
                  ],
                ),
                const Gap(8),
                Text(
                  '${product.brand} - ${product.category}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const Gap(6),
                Text(
                  '${product.stock} left',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
                const Gap(20),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Gap(24),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '\$${product.discountedPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
