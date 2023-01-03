import 'package:flutter/material.dart';

class LastOnBoardingScreen extends StatelessWidget {
  const LastOnBoardingScreen({super.key});

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
                  child: Image.asset("assets/images/on-boaeding-solution.png"))),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 290,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      "دلوقتي تقدر تطلب من البيت و الموصلات او حتي من الشارع  ",
                      style: TextStyle(
                          fontFamily: 'permanentMarker',
                          color: Colors.black,
                          fontSize: 22,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
              Positioned(
              top: MediaQuery.of(context).size.height / 2 + 100,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      "وتستلم الاوردر في الوقت والمكان الي علي مزاجك  ",
                      style: TextStyle(
                          fontFamily: 'permanentMarker',
                          color: Colors.black,
                          fontSize: 22,
                          ),
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
