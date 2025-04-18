import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ProductModel.fromMap(data);
    }).toList();
  }
}
