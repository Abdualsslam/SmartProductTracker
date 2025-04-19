import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_product_tracker/featuers/alerts/data/datasources/alert_remote_data_source_impl.dart';
import 'package:smart_product_tracker/featuers/alerts/data/models/price_alert_model.dart';

class AlertRemoteDataSourceImpl implements AlertRemoteDataSource {
  final FirebaseFirestore firestore;

  AlertRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addAlert(String userId, PriceAlertModel alert) async {
    await firestore.collection('users').doc(userId).collection('alerts').doc(alert.productId).set(alert.toJson());
  }

  @override
  Future<void> deleteAlert(String userId, String productId) async {
    await firestore.collection('users').doc(userId).collection('alerts').doc(productId).delete();
  }

  @override
  Future<List<PriceAlertModel>> getAllAlerts(String userId) async {
    final snapshot = await firestore.collection('users').doc(userId).collection('alerts').get();

    return snapshot.docs.map((doc) => PriceAlertModel.fromJson(doc.data())).toList();
  }
}
