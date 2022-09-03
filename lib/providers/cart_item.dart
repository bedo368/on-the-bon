import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  double quantity;
  final double price;
  final String imageUrl;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl,
      this.quantity = 1});
}
