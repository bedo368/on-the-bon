import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
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
        await auth.signInWithCredential(credential);
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
