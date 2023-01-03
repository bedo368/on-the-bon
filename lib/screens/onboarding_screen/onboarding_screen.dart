import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';

import 'package:on_the_bon/screens/onboarding_screen/first_screen.dart';
import 'package:on_the_bon/screens/onboarding_screen/force_screen.dart';
import 'package:on_the_bon/screens/onboarding_screen/last_screen.dart';
import 'package:on_the_bon/screens/onboarding_screen/second_screen.dart';
import 'package:on_the_bon/screens/onboarding_screen/thired_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLastPage = false;
  final controller = PageController();
  @override
  void initState() {
    controller.addListener(() {
      if (controller.page! < 4) {
        setState(() {
          isLastPage = false;
        });
      }
      if (controller.page! == 4) {
        setState(() {
          isLastPage = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            FirstOnBoardingScreen(),
            SecondOnBoardingScreen(),
            ThierdOnBoardingScreen(),
            ForceOnBoardingScreen(),
            LastOnBoardingScreen()
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
                height: 70,
                // color:Color.fromARGB(244, 218, 213, 213),
                color: Theme.of(context).primaryColor,
                child: isLastPage
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary),
                          child: Text(
                            "يـلا  بـيـنـا",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (controller.page == 4) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("hideonboardscreen", true);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            }
                          },
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            right: 0,
                            child: TextButton(
                              onPressed: () async {
                                await controller.previousPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                                setState(() {});
                              },
                              child: Text(
                                "السابق",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: TextButton(
                              onPressed: () async {
                                if (controller.page != null) {
                                  if (controller.page! < 4) {
                                    await controller.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                    setState(() {});
                                  }
                                  if (controller.page == 4) {
                                    setState(() {
                                      isLastPage = true;
                                    });
                                  }
                                }
                              },
                              child: Text(
                                "التالي",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                              child: SmoothPageIndicator(
                            onDotClicked: (index) {
                              controller.animateToPage(index,
                                  duration: Duration(
                                    milliseconds: 1000,
                                  ),
                                  curve: Curves.easeIn);
                            },
                            controller: controller,
                            count: 5,
                            effect: WormEffect(
                                dotHeight: 12,
                                dotWidth: 12,
                                spacing: 10,
                                strokeWidth: .4,
                                dotColor: Colors.white,
                                activeDotColor:
                                    Theme.of(context).colorScheme.secondary),
                          ))
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
