import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:rive/rive.dart';

class Floatingsky extends StatefulWidget {
  const Floatingsky({super.key,  required this.typeName});
  final String typeName;

  @override
  State<Floatingsky> createState() => _FloatingskyState();
}

class _FloatingskyState extends State<Floatingsky> {
  SMIInput<bool>? isSelectedInput;
  Artboard? floatingSkyArtboard;
  final List<String> types = productsStringToType.keys.toList();

  @override
  void initState() {
    rootBundle.load("assets/animation/flooating_sky.riv").then((value) {
      final file = RiveFile.import(value);
      final artBoard = file.mainArtboard;

      var isSelectedController = StateMachineController.fromArtboard(
        artBoard,
        "selectedType",
      );

      if (isSelectedController != null) {
        artBoard.addController(isSelectedController);
        isSelectedInput = isSelectedController.findInput("selected");
        floatingSkyArtboard = artBoard;
      }

      setState(() {
        isSelectedInput!.value =
            HomeScreen.productType.value == widget.typeName ? true : false;
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    SMITrigger? isClickedTriger;
    SMIInput<bool>? isSleepy;
    SMIInput<bool>? isDark;

    void getSleepy() {
      void getUp() {
        Future.delayed(Duration(seconds: Random().nextInt(50))).then((value) {
          if (isSelectedInput!.value != false) {
            isSleepy!.value = true;
            getSleepy();
          }
        });
      }

      Future.delayed(Duration(seconds: Random().nextInt(20))).then((value) {
        if (isSelectedInput!.value != false) {
          isSleepy!.value = false;
        }
      }).then((value) {
        getUp();
      });
    }

    getDark() {
      void getlight() {
        Future.delayed(Duration(seconds: Random().nextInt(60))).then((value) {
          if (isDark!.value != true) {
            isDark!.value = true;
            getDark();
          }
        });
      }

      Future.delayed(Duration(seconds: Random().nextInt(30))).then((value) {
        if (isDark!.value != false) {
          isDark!.value = false;
        }
      }).then((value) {
        getlight();
      });
    }

    void addAndRemoveBlankingController() {
      if (floatingSkyArtboard != null &&
          HomeScreen.productType.value == widget.typeName) {
        var blanking = StateMachineController.fromArtboard(
          floatingSkyArtboard!,
          "blanking",
        );
        isSleepy = blanking!.findInput("isIdle");

        isClickedTriger = blanking.findSMI("Click");
        isDark = blanking.findSMI("isDark");
        floatingSkyArtboard!.addController(blanking);
        getDark();
        getSleepy();
      }
      if (floatingSkyArtboard != null &&
          HomeScreen.productType.value != widget.typeName) {
        var blanking = StateMachineController.fromArtboard(
          floatingSkyArtboard!,
          "blanking",
        );

        isClickedTriger = null;
        floatingSkyArtboard!.removeController(blanking!);
      }
    }

    if (floatingSkyArtboard != null) {
      isSelectedInput!.value =
          HomeScreen.productType.value == widget.typeName ? true : false;
      addAndRemoveBlankingController();
    }
    return floatingSkyArtboard != null
        ? GestureDetector(
            onTap: () {
              if (isSelectedInput!.value != false) {
                setState(() {
                  if (isClickedTriger != null) {
                    isClickedTriger!.fire();
                  }
                });
              }
            },
            child: Rive(
              artboard: floatingSkyArtboard!,
              fit: BoxFit.cover,
            ),
          )
        : Container();
  }
}
