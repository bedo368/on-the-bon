import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  final _cartitems = {"totalPrice": 0, "deliveryCost": 5, "totalcost": 5};

  get cartItems {
    return {..._cartitems};
  }
}
