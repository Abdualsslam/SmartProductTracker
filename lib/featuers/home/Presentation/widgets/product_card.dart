import 'package:flutter/material.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl),
        title: Text(product.title),
        subtitle: Text('price: ${product.discountPrice}'),
        trailing: IconButton(
          icon: Icon(Icons.notifications_active),
          onPressed: () {
            // Show dialog to set alert price
          },
        ),
      ),
    );
  }
}
