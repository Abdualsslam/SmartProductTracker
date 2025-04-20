import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_state.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/widgets/price_alert_dialog.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/product_details_view.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';
import 'package:collection/collection.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertCubit, AlertState>(
      builder: (context, state) {
        bool showAlert = false;
        print(product.title);
        if (state is AlertLoaded) {
          showAlert = shouldShowAlert(product, state.alerts);
        }
        return Container(
          height: 130,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 44),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
            border: showAlert ? Border.all(color: Colors.red, width: 2) : null,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 88,
                      width: 88,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Text(product.storeName, style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(width: 8),
                        Row(
                          children: [
                            product.discountPrice != null
                                ? Text(
                                  "\$${product.originalPrice}",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                                : Text(
                                  "\$${product.originalPrice}",
                                  style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                            SizedBox(width: 16),
                            product.discountPrice != null
                                ? Text("\$${product.discountPrice}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                                : SizedBox(),
                            IconButton(
                              icon: Icon(Icons.open_in_new_outlined),
                              onPressed: () {
                                final alertCubit = context.read<AlertCubit>();
                                final alertsState = alertCubit.state;

                                PriceAlert? matchedAlert;

                                if (alertsState is AlertLoaded) {
                                  matchedAlert = alertsState.alerts.firstWhereOrNull((a) => a.productId == product.id);
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider.value(
                                          value: alertCubit,
                                          child: ProductDetailsView(product: product, alert: matchedAlert),
                                        ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.notifications_active, color: showAlert ? Colors.red : Colors.black54, size: 30),
                    onPressed: () async {
                      final price = await showPriceAlertDialog(context, product.id);
                      if (price != null) {
                        final alert = PriceAlert(productId: product.id, targetPrice: price);
                        context.read<AlertCubit>().addAlert(alert);
                      }
                    },
                  ),
                ),
                if (showAlert) Positioned(top: 4, right: 4, child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent)),
              ],
            ),
          ),
        );
      },
    );
  }
}

PriceAlert? findAlertByProductId(String productId, List<PriceAlert> alerts) {
  try {
    print("🔍 Looking for alert with productId: $productId");
    for (var a in alerts) {
      print("📦 Alert: ${a.productId}");
    }

    return alerts.firstWhere((alert) => alert.productId.toString() == productId.toString());
  } catch (e) {
    print("❌ No matching alert found: $e");
    return null;
  }
}

bool shouldShowAlert(ProductEntity product, List<PriceAlert> alerts) {
  final alert = findAlertByProductId(product.id, alerts);
  if (alert == null) {
    print("🚫 No alert found for product: ${product.id}");
    return false;
  }

  final currentPrice = product.discountPrice ?? product.originalPrice;
  print("🟢 Product ${product.id} - currentPrice: $currentPrice - target: ${alert.targetPrice}");

  if (currentPrice < alert.targetPrice || currentPrice == alert.targetPrice) {
    return true;
  } else {
    return false;
  }
}
