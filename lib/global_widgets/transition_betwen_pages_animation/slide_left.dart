import 'package:flutter/material.dart';

class SlidePageToLeft extends PageRouteBuilder {
  final Widget page;
  SlidePageToLeft(this.page)
      : super(
            pageBuilder: (context, animation, animatiotwo) => page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
                    final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);


              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            });
}
