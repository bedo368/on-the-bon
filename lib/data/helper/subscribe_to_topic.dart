import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SubscribeToNotificationTopic {
  static void subscreibToAdmin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final isAdmin = await FirebaseFirestore.instance
          .collection("admins")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (isAdmin.id.isNotEmpty) {
        if (isAdmin.data()!["admin"] == true) {
          final fcm = FirebaseMessaging.instance;
          await fcm.getToken();
          fcm.subscribeToTopic("Admin");
        }
      }
    }
  }

  static void subscreibToUsers() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.getToken();
    await fcm.subscribeToTopic("users");
  }
}
