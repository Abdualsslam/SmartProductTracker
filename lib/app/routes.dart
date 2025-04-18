import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/auth_cubit/cubit/auth_cubit.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/views/forgot_password_view.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/views/sign_in_view.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/views/sign_up_view.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/home_view.dart';
import 'package:smart_product_tracker/featuers/splash/Presentation/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: '/home', builder: (context, state) => HomeView()),
    GoRoute(path: "/signUp", builder: (context, state) => BlocProvider(create: (context) => AuthCubit(), child: const SignUpView())),
    GoRoute(path: "/signIn", builder: (context, state) => BlocProvider(create: (context) => AuthCubit(), child: const SignInView())),
    GoRoute(
      path: "/forgotPassword",
      builder: (context, state) => BlocProvider(create: (context) => AuthCubit(), child: const ForgotPasswordView()),
    ),
  ],
);
