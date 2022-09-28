import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({
    Key? key,
    required this.isFav,
  }) : super(key: key);

  final bool isFav;

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart> {
  SMIInput<bool>? isFavoriteInput;
  Artboard? isFavoriteArtboard;
  @override
  void initState() {
    rootBundle.load("assets/animation/heart.riv").then((value) {
      final file = RiveFile.import(value);
      final artBoard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
        artBoard,
        "isFaivoriteState",
      );
      if (controller != null) {
        artBoard.addController(controller);
        isFavoriteInput = controller.findInput("isFaivoriteInput");
        isFavoriteArtboard = artBoard;
      }
      setState(() {
        isFavoriteInput!.value = widget.isFav;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFavoriteArtboard != null) {
      isFavoriteInput!.value = widget.isFav;
    }
    return isFavoriteArtboard != null
        ? Rive(
            artboard: isFavoriteArtboard!,
            fit: BoxFit.cover,
          )
        : Container();
  }
}
