import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String discription;
  final Map<String, double> sizePrice;
  final String type;
  final String subType;
  final String imageUrl;
  bool isFav;
  Product(
      {required this.id,
      required this.title,
      required this.discription,
      required this.sizePrice,
      required this.type,
      required this.subType,
      required this.imageUrl,
      this.isFav = false});

  Future updateProductFavoriteState(String id) async {
    try {
      if (!isFav) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "faivorites": FieldValue.arrayUnion([id])
        });

        isFav = true;

        notifyListeners();
        return;
      } else if (isFav) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "faivorites": FieldValue.arrayRemove([id])
        });
        isFav = false;

        notifyListeners();
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
