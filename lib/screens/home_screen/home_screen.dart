import 'package:flutter/material.dart';
import 'package:on_the_bon/helper/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ElevatedButton(
            onPressed: () {
              Auth.signOut();
            },
            child: const Text("logout")),
        
      ]),
    );
  }
}
