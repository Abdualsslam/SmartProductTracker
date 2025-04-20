import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/services/service_locator.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_state.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_cubit.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_state.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool hasPlayedSound = false;
  final AudioPlayer player = AudioPlayer();

  Future<void> playAlertSound() async {
    try {
      await player.play(AssetSource('audio/alert.mp3')); // تأكد من الملف في assets
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  List<ProductEntity> findProductsWithAlerts(List<ProductEntity> products, List<PriceAlert> alerts) {
    return products.where((product) {
      final matchingAlert = alerts.where((a) => a.productId == product.id).firstOrNull;
      if (matchingAlert == null) return false;
      final currentPrice = product.discountPrice ?? product.originalPrice;
      return currentPrice <= matchingAlert.targetPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeCubit>()..fetchProducts()),
        BlocProvider(create: (_) => AlertCubit(addAlert: sl(), deleteAlert: sl(), getAllAlerts: sl())..fetchAlerts()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Product Tracker', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                customNavigate(context, '/signIn');
              },
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BlocBuilder<AlertCubit, AlertState>(
              builder: (context, alertState) {
                if (state is HomeLoading || alertState is AlertLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is HomeError) {
                  return Center(child: Text(state.message));
                }

                if (state is HomeLoaded && alertState is AlertLoaded) {
                  final alertProducts = findProductsWithAlerts(state.products, alertState.alerts);

                  if (!hasPlayedSound && alertProducts.isNotEmpty) {
                    playAlertSound();
                    hasPlayedSound = true;
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      hasPlayedSound = false;
                      context.read<HomeCubit>().fetchProducts();
                      context.read<AlertCubit>().fetchAlerts();
                    },
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (_, i) {
                        final product = state.products[i];
                        return ProductCard(product: product);
                      },
                    ),
                  );
                }

                return SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Smart Product Tracker'), centerTitle: true, automaticallyImplyLeading: false),
//       body: Column(
//         children: [
//           Center(child: Text('Welcome to Smart Product Tracker!', style: Theme.of(context).textTheme.displayLarge)),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 customNavigate(context, '/signIn');
//               },
//               child: Text('log out'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
