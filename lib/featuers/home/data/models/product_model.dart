import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends ProductEntity {
  @HiveField(0)
  final String productId;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final String imageUrl;

  @override
  @HiveField(3)
  final double originalPrice;

  @override
  @HiveField(4)
  final double discountPrice;

  @override
  @HiveField(5)
  final String storeName;

  @override
  @HiveField(6)
  final String description;

  ProductModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountPrice,
    required this.storeName,
    required this.description,
  }) : super(
         id: productId,
         title: title,
         imageUrl: imageUrl,
         originalPrice: originalPrice,
         discountPrice: discountPrice,
         storeName: storeName,
         description: description,
       );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      originalPrice: (map['originalPrice'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      storeName: map['storeName'],
      description: map['description'] ?? '',
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
      'description': description,
    };
  }
}
