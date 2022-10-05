import 'package:flutter/material.dart';

class SlidePageToRight extends PageRouteBuilder {
  final Widget page;
  SlidePageToRight(this.page)
      : super(
            pageBuilder: (context, animation, animatiotwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
              final curvesAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);

              return SlideTransition(
                position: tween.animate(curvesAnimation),
                child: child,
              );
            });
}
