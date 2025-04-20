import 'package:flutter/material.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key, required this.text1, required this.text2, this.onTap});
  final String text1, text2;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: text1, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
              TextSpan(
                text: text2,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(decoration: TextDecoration.underline, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
