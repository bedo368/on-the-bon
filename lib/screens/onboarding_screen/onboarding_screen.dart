import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:on_the_bon/screens/onboarding_screen/first_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          children: [
            FirstOnBoardingScreen(),
            FirstOnBoardingScreen(),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 170,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 10,
              child: Container(
                  color: Colors.white,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/coffee.png",
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
