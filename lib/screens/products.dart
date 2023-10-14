import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/product.dart';
import '../providers/products.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return products.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(
        child: Text('An error occured'),
      ),
      data: (products) => RefreshIndicator(
        onRefresh: () => ref.refresh(productsProvider.future),
        child: GridView.builder(
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: products.length,
          itemBuilder: (_, index) => ProductCard(products[index]),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/product/${product.id}'),
      child: Card(
        child: PaddedColumn(
          padding: const EdgeInsets.all(8),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.thumbnail,
                    height: 144,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Text('${product.rating}'),
                        const Gap(2),
                        Icon(Icons.star, size: 14, color: Colors.yellow[800]),
                      ],
                    ),
                  ],
                ),
                Text(
                  product.brand,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green[700],
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
