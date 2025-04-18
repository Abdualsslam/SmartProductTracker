import 'package:flutter/material.dart';

class ForgotPasswordSubTitle extends StatelessWidget {
  const ForgotPasswordSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0),
      child: Text(
        "Enter your registered email below to receive password reset instruction",
        style: Theme.of(context).textTheme.headlineSmall,

        textAlign: TextAlign.center,
      ),
    );
  }
}
