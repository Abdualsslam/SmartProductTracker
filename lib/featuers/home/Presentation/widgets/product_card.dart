import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: product.imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
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
