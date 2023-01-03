import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_bon/data/helper/auth.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';

class GoogleSignButton extends StatefulWidget {
  const GoogleSignButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignButton> createState() => _GoogleSignButtonState();
}

class _GoogleSignButtonState extends State<GoogleSignButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ElevatedButton.icon(
          label: isLoading
              ? SpinKitChasingDots(
                  size: 15,
                  color: Colors.white,
                )
              : Text(
                  "Sign with google ",
                  style: TextStyle(color: Colors.white),
                ),
          icon: Icon(
            Ionicons.logo_google,
            color: Colors.white,
          ),
          onPressed: () async {
            try {
              setState(() {
                isLoading = true;
              });
              await Auth.signInWithGoogle(context);
              setState(() {
                isLoading = false;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              // ignore: use_build_context_synchronously

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
