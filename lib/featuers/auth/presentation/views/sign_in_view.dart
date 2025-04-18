import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/custom_signin_form.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/have_an_account_widget.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/welcome_banner.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/welcome_text_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: WelcomeBanner()),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          const SliverToBoxAdapter(child: WelcomeTextWidget(text: AppStrings.welcomeBack)),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: CustomSignInForm())),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: HaveAnAccountWidget(
              text1: AppStrings.dontHaveAnAccount,
              text2: AppStrings.signUp,
              onTap: () {
                customReplacementNavigate(context, "/signUp");
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
