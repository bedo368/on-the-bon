import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/stroked_text.dart';

class SignInLogo extends StatelessWidget {
  const SignInLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: StrockedText(
            "%",
            fontFamily: "permanentMarker",
            strokeColor: Colors.white,
            fontSize: 60,
            shadow: const [],
            strokeWidth: 4,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60),
          child: Center(
            child: StrockedText(
              "On The Bon",
              fontFamily: "RockSalt",
              strokeColor: Colors.white,
              fontSize: 30,
              shadow: const [],
              strokeWidth: 4,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
