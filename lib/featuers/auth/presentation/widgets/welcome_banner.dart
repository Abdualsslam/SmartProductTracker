import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/utils/constants/colors.dart';
import 'package:smart_product_tracker/core/utils/constants/images.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/core/utils/helpers/helper_functions.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 150,
            child: Image(
              image: AssetImage(AppImages.checking),
              width: HelperFunctions.screenWidth(context) * 0.8,
              // height: HelperFunctions.screenHeight(context) * 0.2,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
