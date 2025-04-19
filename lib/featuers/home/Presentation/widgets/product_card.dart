import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/core/services/service_locator.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/widgets/price_alert_dialog.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlertCubit(addAlert: sl(), deleteAlert: sl(), getAllAlerts: sl()),
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 44),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,

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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("\$${product.originalPrice}", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                          SizedBox(width: 55),
                          IconButton(
                            icon: Icon(Icons.open_in_new_outlined),
                            onPressed: () {
                              // Show dialog to set alert price
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
                  icon: Icon(Icons.notifications_active),
                  onPressed: () async {
                    final price = await showPriceAlertDialog(context, product.id);
                    if (price != null) {
                      // Add the alert to the database
                      final alert = PriceAlert(productId: product.id, targetPrice: price);
                      context.read<AlertCubit>().addAlert(alert);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 4,
//       shadowColor: Colors.black.withOpacity(0.2),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

//         onTap: () {
//           print("${product.title} pressed");
//         },
//         leading: CachedNetworkImage(
//           imageUrl: product.imageUrl,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//           fit: BoxFit.cover,
//         ),

//         title: Text(product.title),
//         // subtitle: Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
//         trailing: Text(
//           "\$${product.originalPrice}",
//           textScaler: TextScaler.linear(1.5),
//           style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//     Card(
//       child: ListTile(
//         leading: CachedNetworkImage(
//           imageUrl: product.imageUrl,
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//           fit: BoxFit.cover,
//         ),
//         title: Text(product.title),
//         subtitle: Text('price: ${product.discountPrice}'),
//         trailing: IconButton(
//           icon: Icon(Icons.notifications_active),
//           onPressed: () {
//             // Show dialog to set alert price
//           },
//         ),
//       ),
//     );
//   }
// }
