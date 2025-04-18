import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends ProductEntity {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final double originalPrice;

  @HiveField(4)
  final double discountPrice;

  @HiveField(5)
  final String storeName;

  ProductModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountPrice,
    required this.storeName,
  }) : super(
         id: productId,
         title: title,
         imageUrl: imageUrl,
         originalPrice: originalPrice,
         discountPrice: discountPrice,
         storeName: storeName,
       );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      originalPrice: (map['originalPrice'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      storeName: map['storeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'title': title,
      'imageUrl': imageUrl,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
      'storeName': storeName,
    };
  }
}
