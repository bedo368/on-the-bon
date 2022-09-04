import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/order_item.dart';

class OrderS with ChangeNotifier {
  final Map<String, OrderItem> _orders = {};


  get orders {
    return {..._orders};
  }
}
