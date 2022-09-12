import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/order.dart';
import 'package:on_the_bon/models/order_item.dart';
import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Orders with ChangeNotifier {
  final Map<String, Order> _orders = {};

  List<Order> get orders {
    return [..._orders.values];
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Order>> getOrdersforUserByType(OrderTypeEnum type) async {
    try {
      if (type == OrderTypeEnum.orderInProgress) {
        final orders = await db
            .collection("orderInProgress")
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        for (var element in orders.docs) {
          
          final List<OrderItem> items =
              (element.data()["ordersItems"] as List<Map<String, dynamic>>)
                  .map((e) {
            return OrderItem(
                productId: e["productId"],
                title: e["title"],
                price: e["price"],
                imageUrl: e["imageUrl"],
                size: e["size"]);
          }).toList();

          _orders[element.id] = Order(
              ordersItems: items,
              userId: element.data()["userId"],
              phoneNumber: element.data()["phoneNumber"],
              location: element.data()["location"],
              id: element.id,
              orderType: element.data()["orderType"],
              totalPrice: element.data()["totalPrice"]);
        }
      }
    } catch (e) {
      rethrow;
    }

    return [..._orders.values];
  }

  Future<void> addOrder({
    required List<CartItem> orderItems,
    required String phoneNumber,
    required String location,
    required String userId,
    required double totalPrice,
  }) async {
    final List<Map> items = orderItems.map((e) {
      return {
        "id": e.id,
        "imageUrl": e.imageUrl,
        "price": e.price,
        "quantity": e.quantity,
        "size": e.size,
        "productid": e.productId
      };
    }).toList();

    db.collection("users").doc(userId).set({"PhoneNumber": phoneNumber});
    final newOrder = await db.collection("orderinprogress").add({
      "orderItems": items,
      "userOwner": userId,
      "PhoneNumber": phoneNumber,
      "totalPrice": totalPrice,
    });

    final List<OrderItem> convertorderItems = orderItems.map((e) {
      return OrderItem(
          productId: e.productId,
          title: e.title,
          price: e.price,
          imageUrl: e.imageUrl,
          size: e.size);
    }).toList();

    final String id = newOrder.id;
    _orders[id] = Order(
        orderType: OrderTypeEnum.orderInProgress,
        ordersItems: convertorderItems,
        userId: userId,
        phoneNumber: phoneNumber,
        location: location,
        totalPrice: totalPrice,
        id: id);
    notifyListeners();
  }
}
