import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';

class ForgotPasswordTextWidget extends StatelessWidget {
  const ForgotPasswordTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customReplacementNavigate(context, "/forgotPassword");
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(AppStrings.forgotPassword, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
      ),
    );
  }
}
