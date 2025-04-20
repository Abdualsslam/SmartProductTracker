class ProductEntity {
  final String id;
  final String title;
  final String imageUrl;
  final double originalPrice;
  final double? discountPrice;
  final String storeName;
  final String description;
  ProductEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.originalPrice,
    this.discountPrice,
    required this.storeName,
    required this.description,
  });
}
