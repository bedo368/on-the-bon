import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:on_the_bon/helper/auth.dart';

class GoogleSignButton extends StatelessWidget {
  const GoogleSignButton({required this.setIsLoading});
  final void Function() setIsLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: SignInButton(Buttons.Google, onPressed: () async {
        try {
          setIsLoading();
          await Auth.signInWithGoogle(context);
          setIsLoading();
        } catch (e) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "حدث خطأ ما يرجي المحاوله مره أخري",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
        }
      }),
    );
  }
}
