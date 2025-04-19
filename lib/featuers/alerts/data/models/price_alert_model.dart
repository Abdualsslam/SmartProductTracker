import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';

class PriceAlertModel extends PriceAlert {
  PriceAlertModel({required super.productId, required super.targetPrice});

  factory PriceAlertModel.fromJson(Map<String, dynamic> json) {
    return PriceAlertModel(productId: json['productId'], targetPrice: (json['targetPrice'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'targetPrice': targetPrice};
  }
}
