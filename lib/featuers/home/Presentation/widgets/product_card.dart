import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/core/utils/helpers/helper_functions.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_state.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/widgets/price_alert_dialog.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/product_details_view.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/widgets/product_detail_transition.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';
import 'package:collection/collection.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return BlocBuilder<AlertCubit, AlertState>(
      builder: (context, state) {
        bool showAlert = false;
        if (state is AlertLoaded) {
          showAlert = shouldShowAlert(product, state.alerts);
        }

        return GestureDetector(
          onTap: () {
            final alertCubit = context.read<AlertCubit>();
            final alertsState = alertCubit.state;

            PriceAlert? matchedAlert;

            if (alertsState is AlertLoaded) {
              matchedAlert = alertsState.alerts.firstWhereOrNull((a) => a.productId == product.id);
            }

            Navigator.of(context).push(ProductDetailTransition(page: ProductDetailsView(product: product, alert: matchedAlert)));
          },
          child: Container(
            height: 130,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: HelperFunctions.screenWidth(context) * 0.07),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDark ? Color.fromARGB(255, 27, 27, 31) : Colors.white60,
              border: showAlert ? Border.all(color: Colors.red, width: 2) : null,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: product.id,
                        child: Container(
                          decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(imageUrl: product.imageUrl, height: 88, width: 88, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14)),
                            const SizedBox(height: 8),
                            Text(product.storeName, style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  "\$${product.originalPrice}",
                                  style: TextStyle(
                                    color: isDark ? Colors.deepPurpleAccent : Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    decoration: product.discountPrice != null ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (product.discountPrice != null)
                                  Text("\$${product.discountPrice}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_active,
                        color:
                            showAlert
                                ? Colors.red
                                : isDark
                                ? Colors.white54
                                : Colors.black54,
                        size: 30,
                      ),
                      onPressed: () async {
                        final price = await showPriceAlertDialog(context, product.id);
                        if (price != null) {
                          final alert = PriceAlert(productId: product.id, targetPrice: price);
                          context.read<AlertCubit>().addAlert(alert);
                        }
                      },
                    ),
                  ),
                  if (showAlert) const Positioned(top: 4, right: 4, child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent)),
                ],
              ),
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
