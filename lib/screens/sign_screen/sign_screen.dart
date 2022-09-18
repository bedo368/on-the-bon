import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/sign_screen/widgets/login_with_google_only.dart';
import 'package:on_the_bon/screens/sign_screen/widgets/sign_in_logo.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    // if (Provider.of<User>(context).uid != "") {
    //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    // }
    final mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/login_background1.jpg"),
        fit: BoxFit.fitHeight,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SizedBox(
              width: mediaQuery.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * .8,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: mediaQuery.size.height * .15),
                          child: const SignInLogo(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const LoginWithGoogleForm(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
