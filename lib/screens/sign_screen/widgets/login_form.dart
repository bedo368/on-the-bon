
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/dvider_with_text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: formInputDecortion("Email")),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              decoration: formInputDecortion("Password")),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  primary:
                      Theme.of(context).colorScheme.secondary.withOpacity(.8),
                ),
                onPressed: () {},
                child: const Text(
                  "Login",
                  textAlign: TextAlign.center,
                )),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 40),
            child: const DviderWithText(
              text: "or",
              thickness: 1,
            )),
        CustomBotton(
          content: "Sign With google",
          icon: Icons.email,
          onPress: () {},
          backgoundColor: const Color.fromRGBO(63, 130, 237, .8),
        ),
        CustomBotton(
          content: "Sign With Fcacebook",
          icon: Icons.facebook,
          backgoundColor: const Color.fromRGBO(1, 34, 139, .8),
          onPress: () {},
        ),
        CustomBotton(
          content: "Sign Up With email",
          icon: Icons.alternate_email,
          onPress: () {},
          backgoundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(.8),
        ),
      ],
    ));
  }
}

class CustomBotton extends StatelessWidget {
  final String content;
  final IconData icon;
  final Function() onPress;
  final Color backgoundColor;
  const CustomBotton({
    Key? key,
    required this.content,
    required this.icon,
    required this.onPress,
    required this.backgoundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
            icon: Icon(icon),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              primary: backgoundColor,
            ),
            onPressed: onPress,
            label: Text(
              content,
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}

InputDecoration formInputDecortion(String label) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      fillColor: Colors.white,
      filled: true,
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ));
}
