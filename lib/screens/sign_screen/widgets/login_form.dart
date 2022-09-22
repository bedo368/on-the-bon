import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/dvider_with_text.dart';
import 'package:on_the_bon/data/helper/auth.dart';
import 'package:on_the_bon/screens/sign_screen/widgets/goolge_sign_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  SignMethod _signMethod = SignMethod.login;
  bool isLoading = false;
  final Map<String, String> _formdata = {
    "email": '',
    "password": '',
    "name": ''
  };
  void _submitForm() async {
    setState(() {
      isLoading = true;
    });
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    _formKey.currentState!.save();

    if (_signMethod == SignMethod.signup) {
      final scoffldMessanger = ScaffoldMessenger.of(context);
      try {
        await Auth.signUpWithEmailAndPassword(
            name: _formdata["name"]!,
            email: _formdata["email"]!,
            password: _formdata["password"]!);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        scoffldMessanger.hideCurrentSnackBar();
        scoffldMessanger.showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                textAlign: TextAlign.center,
              )),
        );

      }
      
    } else {
      final scoffldMessanger = ScaffoldMessenger.of(context);
      try {
        await Auth.signInWithEmailAndPassword(
            email: _formdata["email"]!, password: _formdata["password"]!);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        scoffldMessanger.hideCurrentSnackBar();
        scoffldMessanger.showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                textAlign: TextAlign.center,
              )),
        );

      }

    }
    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 600),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  if (_signMethod == SignMethod.signup)
                    Column(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 600),
                          opacity: _signMethod == SignMethod.login ? 0 : 1,
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                                validator: ((name) {
                                  if (name != null) {
                                    if (name.length < 4) {
                                      return "Enter a valid name please ";
                                    }
                                  }
                                  _formdata["name"] = name!;

                                  return null;
                                }),
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) {
                                  _formdata["name"] = newValue!;
                                },
                                key: const Key("Full name"),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                decoration: formInputDecortion("Full name ")),
                          ),
                        ),
                      ],
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: ((email) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email!)) {
                            _formdata["email"] = email;
                            return null;
                          }
                          return "invalid email ";
                        }),
                        onSaved: (newValue) {
                          _formdata["email"] = newValue!;
                        },
                        key: const Key("Email"),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: formInputDecortion("Email")),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: ((password) {
                          if (password != null) {
                            if (password.length < 8) {
                              return "passwrod is to short ";
                            }
                          }
                          _formdata["password"] = password!;

                          return null;
                        }),
                        onSaved: (newValue) {
                          _formdata["password"] = newValue!;
                        },
                        textInputAction: TextInputAction.next,
                        key: const Key("password"),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: formInputDecortion("Password")),
                  ),
                  if (_signMethod == SignMethod.signup)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: ((password) {
                            if (_formdata["password"] != password) {
                              return " password did't match ";
                            }

                            return null;
                          }),
                          textInputAction: TextInputAction.next,
                          key: const Key("conformpassword"),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          decoration: formInputDecortion("conform Password")),
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: CustomBotton(
                        content:
                            " ${_signMethod == SignMethod.login ? 'Login' : 'SignUp'} ",
                        icon: null,
                        onPress: _submitForm,
                        backgoundColor:
                            Theme.of(context).colorScheme.secondary),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const DviderWithText(
                        text: "or",
                        thickness: 1, color: Colors.white,
                      )),
                  GoogleSignButton(setIsLoading: () {
                    setState(() {
                      isLoading = !isLoading;
                    });
                  }),
                  if (_signMethod == SignMethod.login)
                    CustomBotton(
                      content: "Sign up  With Email",
                      icon: Icons.email,
                      onPress: () async {
                        setState(() {
                          _signMethod = SignMethod.signup;
                        });
                      },
                      backgoundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  if (_signMethod == SignMethod.signup)
                    CustomBotton(
                      content: "I have an account ",
                      icon: null,
                      onPress: () async {
                        setState(() {
                          _signMethod = SignMethod.login;
                        });
                      },
                      backgoundColor: Theme.of(context).colorScheme.secondary,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum SignMethod { login, signup }

class CustomBotton extends StatelessWidget {
  final String content;
  final IconData? icon;
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
            child: icon != null
                ? ElevatedButton.icon(
                    icon: Icon(icon),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: backgoundColor,
                    ),
                    onPressed: onPress,
                    label: Text(
                      content,
                      textAlign: TextAlign.center,
                    ))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: backgoundColor,
                    ),
                    onPressed: onPress,
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                    ))));
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

// CustomBotton(
//   content: "Sign With Fcacebook",
//   icon: Icons.facebook,
//   backgoundColor: const Color.fromRGBO(1, 34, 139, .8),
//   onPress: () async {
//     await Auth.signInWithFacebook();
//   },
// ),

//  SignInButton(Buttons.Facebook, onPressed: () async {
//               setState(() {
//                 isLoading = true;
//               });
//               await Auth.signInWithFacebook();
//             })
