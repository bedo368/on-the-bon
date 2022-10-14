import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/data/providers/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  double _itemsCount = 0;
  List<CartItem> get cartItems {
    // notifyListeners();
    return [..._items.values];
  }

  double get itemsCount {
    return _itemsCount;
  }

  double get totalPrice {
    double prcie = 0;
    _items.forEach((key, value) {
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
  }) async {
    String itemkey = "";
    _items.forEach(
      (key, value) {
        if (id == value.productId && size == value.size) {
          _itemsCount += quntity;

          value.increaseQuntity(quntity);
          itemkey = key;
          return;
        }
      },
    );
    if (!_items.containsKey(itemkey)) {
      final String itemId = DateTime.now().toString();
      _itemsCount += quntity;

      _items[itemId] = CartItem(
          id: itemId,
          productId: id,
          title: title,
          price: price,
          imageUrl: imageUrl,
          size: size,
          quantity: quntity);
    }

    notifyListeners();
  }

  void increaseItemBy1(id) {
    if (_items.containsKey(id)) {
      _itemsCount += 1;

      _items[id]!.increaseQuntity(1);
    }
    notifyListeners();
  }

  void decreaseItemBy1(id) {
    if (_items.containsKey(id)) {
      _items[id]!.decreaseQuntity(1);
      _itemsCount -= 1;
    }

    if (_items[id]!.quantity <= 0) {
      _items.remove(id);
    }

    notifyListeners();
  }

  void removeItem(id) {
    _itemsCount -= _items[id]!.quantity;

    _items.remove(id);

    notifyListeners();
  }

  void clearCart() {
    _itemsCount = 0;
    _items.clear();
  }
}
