import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/utils/constants/images.dart';

class ForgotPasswrodImage extends StatelessWidget {
  const ForgotPasswrodImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 235, width: 235, child: Image.asset(AppImages.forgotPassowrd));
  }
}
