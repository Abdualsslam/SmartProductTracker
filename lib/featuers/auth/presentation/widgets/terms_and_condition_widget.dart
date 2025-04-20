import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/utils/constants/texts.dart';
import 'package:smart_product_tracker/featuers/auth/presentation/widgets/custom_check_box.dart';

class TermsAndConditionWidget extends StatelessWidget {
  const TermsAndConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCheckBox(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: AppStrings.iHaveAgreeToOur, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
              TextSpan(
                text: AppStrings.termsAndCondition,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(decoration: TextDecoration.underline, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
