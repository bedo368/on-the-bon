import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String? id;
  String? displayName;
  String? phoneNumber;
  String? email;
  String? location;
  bool? isAdmin;
  String? photoUrl;

  Future fetchUserDataAsync() async {
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    id = userData.id;
    email = userData.data()!["email"];
    photoUrl = userData.data()!["photoURL"];
    displayName = userData.data()!["displayName"];
    phoneNumber = userData.data()!["phoneNumber"];
    location = userData.data()!["location"];
    isAdmin = userData.data()!["isAdmin"];
  }
}
