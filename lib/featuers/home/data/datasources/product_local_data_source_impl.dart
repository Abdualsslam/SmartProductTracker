import 'package:hive/hive.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<ProductModel> box;

  ProductLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await box.clear();
    for (var product in products) {
      await box.put(product.id, product);
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    return box.values.toList();
  }
}
