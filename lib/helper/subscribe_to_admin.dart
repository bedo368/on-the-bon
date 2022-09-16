import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void subscreibToAdmin() async {
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
