import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/order.dart';
import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Orders with ChangeNotifier {
  final Map<String, Order> _orders = {};

  List<Order> get orders {
    return [..._orders.values];
  }

  addOrder({
    required List<CartItem> orderItems,
    required String phoneNumber,
    required String location,
    required String userId,
  }) {
    final String id = DateTime.now().toString();
    _orders[id] = Order(
        orderType: OrderTypeEnum.orderInProgress,
        ordersItems: orderItems,
        userId: userId,
        phoneNumber: phoneNumber,
        location: location,
        id: id);
  }
}
