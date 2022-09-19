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
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final user = await auth.signInWithCredential(credential);
        if (user.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.user!.uid)
              .set({
            "displayName": user.user!.displayName,
            "email": user.user!.email,
            "phoneNumber": user.user!.phoneNumber,
            "photoURL": user.user!.photoURL,
            "creationTime": user.user!.metadata.creationTime
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
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
              await auth.currentUser!.updatePhoneNumber(credential);

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
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("عذرا هناك خطا ما : قد يكون الهاتف مسجل من قبل ")));
              Navigator.of(context).pop();

              rethrow;
            }
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
                  return AlertDialog(
                    title: const Text(" ادخل كود التاكيد من فضلك"),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text(" $phoneNumber :  وصلك كود علي رقم  "),
                          TextField(
                            controller: textController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
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
                              child: const Text("تاكيد")),
                          TextButton(
                              onPressed: () async {
                                retry!();
                              },
                              child: const Text("اعاده الارسال")),
                          TextButton(
                              onPressed: () async {
                                onCancel();
                              },
                              child: const Text("اعاده الارسال")),
                        ],
                      )
                    ],
                  );
                }));
          },
          timeout: const Duration(minutes: 2),
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

  static signOut() async {
    await FirebaseAuth.instance.signOut();
    final fcm = FirebaseMessaging.instance;
    await fcm.getToken();
    fcm.unsubscribeFromTopic("Admin");
  }
}
