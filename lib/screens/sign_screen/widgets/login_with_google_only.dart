import 'package:flutter/material.dart';

import 'package:on_the_bon/screens/sign_screen/widgets/goolge_sign_button.dart';

class LoginWithGoogleForm extends StatefulWidget {
  const LoginWithGoogleForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWithGoogleForm> createState() => _LoginWithGoogleFormState();
}

class _LoginWithGoogleFormState extends State<LoginWithGoogleForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: [
        if (isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GoogleSignButton(),
            ),
          ),
        ),
      ],
    );
  }
}
