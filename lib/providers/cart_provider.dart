import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/providers/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> items = {};
  Map<String, CartItem> get cartItems {
    // notifyListeners();
    return {...items};
  }

  double get totalPrice {
    double prcie = 0;
    items.forEach((key, value) {
      prcie += value.price * value.quantity;
    });
    return prcie;
  }

  void addItemToCartWithQuntity({
    required String title,
    required String id,
    required double price,
    required String imageUrl,
    required String type,
    required String size,
    double quntity = 1,
  }) {
    String itemkey = "";
    items.forEach(
      (key, value) {
        if (id == value.id && size == value.size) {
          value.increaseQuntity(quntity);
          itemkey = key;
          return;
        }
      },
    );
    if (!items.containsKey(itemkey)) {
      items[DateTime.now().toString()] = CartItem(
          id: id,
          title: title,
          type: type,
          price: price,
          imageUrl: imageUrl,
          size: size);
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
