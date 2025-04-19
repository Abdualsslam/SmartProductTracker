import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/services/service_locator.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_cubit.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_state.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/widgets/product_card.dart';

// HomePage
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Product Tracker', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Log out logic here
                customNavigate(context, '/signIn');
              },
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) return Center(child: CircularProgressIndicator());
            if (state is HomeError) return Center(child: Text(state.message));
            if (state is HomeLoaded) {
              return RefreshIndicator(
                onRefresh: () async => context.read<HomeCubit>().fetchProducts(),
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
