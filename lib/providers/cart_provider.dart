import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/providers/cart_item.dart';

class Cart with ChangeNotifier {
  double totalPrice = 0;

  final Map<String, CartItem> items = {};
  Map<String, CartItem> get cartItems {
    // notifyListeners();
    return {...items};
  }

  void addItemToCartWithQuntity({
    required String title,
    required String id,
    required double price,
    required String imageUrl,
    required String type,
    double quntity = 1,
  }) {
    if (items.containsKey(id)) {
      items[id]!.increaseQuntity(quntity);
    } else if (!items.containsKey(id)) {
      items[id] = CartItem(
          id: id, title: title, price: price, imageUrl: imageUrl, type: type);
    }
    notifyListeners();
  }

  void increaseItemBy1(id) {
    if (items.containsKey(id)) {
      items[id]!.increaseQuntity(1);
    }
    notifyListeners();
  }

  void decreaseItemBy1(id) {
    if (items.containsKey(id)) {
      items[id]!.decreaseQuntity(1);
    }
    if (items[id]!.quantity <= 0) {
      items.remove(id);
    }
    notifyListeners();
  }

  void removeItem(id) {
    if (items.containsKey(id)) {
      items.remove(id);
    }
    notifyListeners();
  }
}
