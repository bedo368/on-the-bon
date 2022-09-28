import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:rive/rive.dart';

class Floatingsky extends StatefulWidget {
  const Floatingsky({super.key, required this.index});
  final int index;

  @override
  State<Floatingsky> createState() => _FloatingskyState();
}

class _FloatingskyState extends State<Floatingsky> {
  SMIInput<bool>? isSelectedInput;
  Artboard? isSelectedArtboard;
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
        isSelectedArtboard = artBoard;
      }

      setState(() {
        isSelectedInput!.value = HomeScreen.productType.value ==
                productsStringToType[types[widget.index]]
            ? true
            : false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SMITrigger? isClickedTriger;
    SMIInput<bool>? isSleepy;

    void getSleepy() {
      void getUp() {
        Future.delayed(const Duration(seconds: 30)).then((value) {
          if (isSelectedInput!.value != false) {
            isSleepy!.value = true;
            getSleepy();
          }
        });
      }

      Future.delayed(const Duration(seconds: 8)).then((value) {
        if (isSelectedInput!.value != false) {
          isSleepy!.value = false;
        }
      }).then((value) {
        getUp();
      });
    }

    void addAndRemoveBlankingController() {
      if (isSelectedArtboard != null &&
          HomeScreen.productType.value ==
              productsStringToType[types[widget.index]]) {
        var blanking = StateMachineController.fromArtboard(
          isSelectedArtboard!,
          "blanking",
        );
        isSleepy = blanking!.findInput("isIdle");

        isClickedTriger = blanking.findSMI("Click");
        isSelectedArtboard!.addController(blanking);
        getSleepy();
      }
      if (isSelectedArtboard != null &&
          HomeScreen.productType.value !=
              productsStringToType[types[widget.index]]) {
        var blanking = StateMachineController.fromArtboard(
          isSelectedArtboard!,
          "blanking",
        );

        isClickedTriger = null;
        isSelectedArtboard!.removeController(blanking!);
      }
    }

    if (isSelectedArtboard != null) {
      isSelectedInput!.value = HomeScreen.productType.value ==
              productsStringToType[types[widget.index]]
          ? true
          : false;
      addAndRemoveBlankingController();
    }
    return isSelectedArtboard != null
        ? GestureDetector(
            onTap: () {
              if (isSelectedInput!.value != false) {
                setState(() {
                  isClickedTriger!.fire();
                });
              }
            },
            child: Rive(
              artboard: isSelectedArtboard!,
              fit: BoxFit.cover,
            ),
          )
        : Container();
  }
}
