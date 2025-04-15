import 'package:go_router/go_router.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/home_view.dart';
import 'package:smart_product_tracker/featuers/splash/Presentation/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
  ],
);
