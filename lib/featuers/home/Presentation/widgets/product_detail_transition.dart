import 'package:flutter/widgets.dart';

class ProductDetailTransition extends PageRouteBuilder {
  final Widget page;

  ProductDetailTransition({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // يطلع من تحت لفوق
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
          );
        },
      );
}
