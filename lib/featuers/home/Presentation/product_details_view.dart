import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductEntity product;
  final PriceAlert? alert;

  const ProductDetailsView({super.key, required this.product, this.alert});

  @override
  Widget build(BuildContext context) {
    final currentPrice = product.discountPrice ?? product.originalPrice;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(imageUrl: product.imageUrl, height: 250, width: double.infinity, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(' Current Price: \$${currentPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.green)),
            if (product.discountPrice != null)
              Text(
                ' Original Price : \$${product.originalPrice.toStringAsFixed(2)}',
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
            const SizedBox(height: 12),
            Text('Description:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(product.description ?? 'No Description'),
            const SizedBox(height: 20),
            if (alert != null && alert!.productId == product.id && product.originalPrice <= alert!.targetPrice) ...[
              const SizedBox(height: 30),
              Text(
                'An alert is set when the price reaches: \$${alert!.targetPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AlertCubit>().deletePriceAlert(product.id);
                  Navigator.pop(context); // نرجع بعد حذف التنبيه
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete Alert'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
