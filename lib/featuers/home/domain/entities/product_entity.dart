class ProductEntity {
  final String id;
  final String title;
  final String imageUrl;
  final double originalPrice;
  final double discountPrice;
  final String storeName;

  ProductEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountPrice,
    required this.storeName,
  });
}
