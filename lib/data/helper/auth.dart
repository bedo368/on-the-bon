import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final user = await auth.signInWithCredential(credential);

        if (!user.additionalUserInfo!.isNewUser) {
          final fcm = FirebaseMessaging.instance;
          final deviceNotificationId = await fcm.getToken();
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.user!.uid)
              .update({
            "deviceNotificationId": deviceNotificationId,
          });
        }

        if (user.additionalUserInfo!.isNewUser) {
          final fcm = FirebaseMessaging.instance;
          final deviceNotificationId = await fcm.getToken();
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.user!.uid)
              .set({
            "displayName": user.user!.displayName,
            "email": user.user!.email,
            "phoneNumber": user.user!.phoneNumber,
            "photoURL": user.user!.photoURL,
            "creationTime": user.user!.metadata.creationTime,
            "deviceNotificationId": deviceNotificationId,
            "isAdmin": false
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // ignore: use_build_context_synchronously

        // handle the error here
      }
    }
  }

  static signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    final auth = FirebaseAuth.instance;
    try {
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await newUser.user!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw "email-already-in-use";
      } else if (e.code == "invalid-email") {
        throw 'invalid-email';
      } else if (e.code == "weak-password") {
        throw "weak-password";
      } else {
        throw "something wroung happend please try again";
      }
    } catch (e) {
      rethrow;
    }
  }

  static signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw "please enter valid email ";
      } else if (e.code == "user-not-found") {
        throw 'can not found user ';
      } else if (e.code == "wrong-password") {
        throw "wrong-password";
      } else {
        throw "something wroung happend please try again";
      }
    } catch (e) {
      throw "some thing wroung happen please try again";
    }
  }

  static Future verifyPhoneNumber(
      {Function? retry,
      required String phoneNumber,
      required BuildContext context,
      required Function onCancel,
      required Function(BuildContext context) confirmOrder,
      required String location}) async {
    final auth = FirebaseAuth.instance;
    bool confirmationState = false;

    try {
      if (auth.currentUser!.phoneNumber == null ||
          auth.currentUser!.phoneNumber != "+2$phoneNumber") {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+2$phoneNumber',
          verificationCompleted: (PhoneAuthCredential credential) async {
            try {
              if (!confirmationState) {
                await auth.currentUser!.updatePhoneNumber(credential);
                await auth.currentUser!.unlink(PhoneAuthProvider.PROVIDER_ID);

                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(auth.currentUser!.uid)
                    .update({
                  "phoneNumber": phoneNumber,
                  "location": location,
                  "verfiedPhone": true
                });
                // ignore: use_build_context_synchronously
                await confirmOrder(context);
                // ignore: use_build_context_synchronously
                // Navigator.of(context).pop();

              }
            } catch (e) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("عذرا هناك خطا ما : قد يكون الهاتف مسجل من قبل ")));
              Navigator.of(context).pop();

              rethrow;
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.message.toString()),
              duration: const Duration(seconds: 20),
            ));
          },
          codeSent: (String verificationId, int? resendToken) async {
            final TextEditingController textController =
                TextEditingController();

            await showDialog(
                context: context,
                builder: ((context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: AlertDialog(
                      title: const Text(" ادخل كود التاكيد من فضلك"),
                      content: SizedBox(
                        height: 130,
                        child: Column(
                          children: [
                            Text("وصلك كود علي رقم : $phoneNumber "),
                            TextField(
                              controller: textController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "ادخل الكود هنا",
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  final smscidintial =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: textController.text);

                                  try {
                                    await auth.currentUser!
                                        .updatePhoneNumber(smscidintial);
                                    await auth.currentUser!
                                        .unlink(PhoneAuthProvider.PROVIDER_ID);

                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(auth.currentUser!.uid)
                                        .update({
                                      "phoneNumber": phoneNumber,
                                      "location": location,
                                      "verfiedPhone": true
                                    });
                                    // ignore: use_build_context_synchronously
                                    await confirmOrder(context);
                                    confirmationState = true;

                                    // ignore: use_build_context_synchronously
                                    // Navigator.of(context).pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "عذرا هناك خطا ما : قد يكون الهاتف مسجل من قبل ")));
                                    Navigator.of(context).pop();

                                    rethrow;
                                  }
                                },
                                child: const Text(
                                  "تاكيد",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  onCancel();
                                },
                                child: const Text(
                                  "الغاء",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                }));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        return confirmationState;
      } else if (auth.currentUser!.phoneNumber! == "+2$phoneNumber") {
        await confirmOrder(context);
        return true;
      }
    } catch (e) {
      return false;
    }
    return confirmationState;
  }

  // static updatePhonNumber(User user) {
  //   FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: const Duration(minutes: 2),
  //       verificationCompleted: (credential) async {
  //         await user.updatePhoneNumber(phoneCredential);
  //         // either this occurs or the user needs to manually enter the SMS code
  //       },
  //       verificationFailed: null,
  //       codeSent: (verificationId, [forceResendingToken]) async {
  //         String smsCode;
  //         // get the SMS code from the user somehow (probably using a text field)
  //         final AuthCredential credential = PhoneAuthProvider.getCredential(
  //             verificationId: verificationId, smsCode: smsCode);
  //         await (await FirebaseAuth.instance.currentUser())
  //             .updatePhoneNumberCredential(credential);
  //       },
  //       codeAutoRetrievalTimeout: null);
  // }

  // static signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance
  //       .login(permissions: ['email', 'public_profile']);
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    final fcm = FirebaseMessaging.instance;
    await fcm.getToken();
    await fcm.unsubscribeFromTopic("Admin");
    // ignore: use_build_context_synchronously
  }
}
