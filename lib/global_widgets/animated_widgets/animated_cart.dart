import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedCart extends StatefulWidget {
  const AnimatedCart({super.key, required this.presssed});
  final Function presssed;

  @override
  State<AnimatedCart> createState() => _AnimatedCartState();
}

class _AnimatedCartState extends State<AnimatedCart> {
  Artboard? cartArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;
  @override
  void initState() {
    rootBundle.load('assets/animation/cart.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "addAnimation");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);
          trigger = stateMachineController!.findSMI('clicked');

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }
          trigger = stateMachineController!.inputs.first as SMITrigger;
        }

        setState(() => cartArtboard = artboard);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return cartArtboard != null
        ? GestureDetector(
            onTap: () {
              widget.presssed();
              trigger!.fire();
            },
            child: Rive(
              artboard: cartArtboard!,
            ),
          )
        : Container();
  }
}
