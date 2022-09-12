import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String productId;

  final String title;
  double quantity;
  final double price;
  final String imageUrl;
  String size;
  CartItem({
    required this.productId,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    required this.size,
  });

  void increaseQuntity(double q) {
    notifyListeners();
    if (quantity > 50) {
      return;
    }
    quantity += q;
  }

  void decreaseQuntity(double q) {
    notifyListeners();
    if (quantity <= 0) {
      return;
    }

    quantity -= q;
  }
}
