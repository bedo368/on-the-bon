import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
        title: json['title'],
        productId: json["productId"],
        id: json["id"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        size: json["size"],
        quantity: json["quantity"],
      );

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
