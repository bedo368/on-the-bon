import 'package:flutter/material.dart';

class ForceOnBoardingScreen extends StatelessWidget {
  const ForceOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              // top: MediaQuery.of(context).size.height / 2 - 170,
              child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Image.asset("assets/images/on-boarding-idea.png"))),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 240,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      " الحل عندنا  😎 ",
                      style: TextStyle(
                          fontFamily: 'permanentMarker',
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
