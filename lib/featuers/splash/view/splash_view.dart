import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/utils/constants/images.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(AppTexts.welcomeMessage, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center)),
          SizedBox(height: 20),
          SizedBox(
            height: 100,
            width: 100,
            child: Container(
              color: Colors.white10,
              child: Image(
                // width: HelperFunctions.screenWidth() * 0.8,
                // height: HelperFunctions.screenHeight() * 0.6,
                image: AssetImage(AppImages.priceLogo),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
