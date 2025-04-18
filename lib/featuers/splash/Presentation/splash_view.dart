import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigate_based_on_auth.dart';
import 'package:smart_product_tracker/core/utils/constants/colors.dart';
import 'package:smart_product_tracker/core/utils/constants/images.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/core/utils/helpers/helper_functions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigateBasedOnAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(AppStrings.welcomeMessage, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center)),
          SizedBox(height: 20),
          SizedBox(
            child: Image(
              width: HelperFunctions.screenWidth(context) * 0.8,
              height: HelperFunctions.screenHeight(context) * 0.6,
              image: AssetImage(AppImages.priceLogo),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
