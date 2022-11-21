import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/floating_sky_for_faivorite_element.dart';

class FirstOnBoardingScreen extends StatelessWidget {
  const FirstOnBoardingScreen({super.key});

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
              top: MediaQuery.of(context).size.height / 2 - 240,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "مرحـبـاً . . .",
                  style: TextStyle(
                      fontFamily: 'permanentMarker',
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 290,
              // right: MediaQuery.of(context).size.width / 2 - 90,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  width: 60,
                  height: 50,
                  child: Floatingsky(),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 170,
              child: FittedBox(
                child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Image.asset("assets/images/coffe-shop.png")),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 40,
              right: MediaQuery.of(context).size.width / 2 - 50,
              child: FittedBox(
                child: Container(
                    width: 40, child: Image.asset("assets/images/men.png")),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 40,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: FittedBox(
                child: Container(
                    width: 40, child: Image.asset("assets/images/women.png")),
              )),
          // Positioned(
          //   top: MediaQuery.of(context).size.height / 2+150,
          //   child: Text(
          //     "مشروبك المفضل لدينا 🖤 🖤",
          //     style: TextStyle(
          //         fontFamily: 'permanentMarker',
          //         color: Colors.black,
          //         fontSize: 20,
          //         ),
          //   ),
          // )
        ],
      ),
    );
  }
}
