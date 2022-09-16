import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/order.dart';
import 'package:on_the_bon/models/order_item.dart';
import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Orders with ChangeNotifier {
  final Map<String, Order> _orders = {};

  final Map<OrderTypeEnum, String> ordersTypeEnumToStringE = {
    OrderTypeEnum.successfulOrder: "sucessfulOrder",
    OrderTypeEnum.orderInProgres: "orderInProgres",
    OrderTypeEnum.rejectedOrder: "rejectedOrder",
  };

  List<Order> get orders {
    return [..._orders.values];
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future getOrdersforUserByType(OrderTypeEnum type) async {
    final String orderType = ordersTypeEnumToStringE[type]!;
    try {
      _orders.clear();
      final orders = await db
          .collection(orderType)
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (var element in orders.docs) {
        final List<OrderItem> items = [];

        for (var e in (element.data()["orderItems"] as List<dynamic>)) {
          items.add(OrderItem(
              productId: e["productId"],
              quantity: e["quantity"],
              title: e["title"],
              price: e["price"],
              imageUrl: e["imageUrl"],
              size: e["size"]));
        }

        _orders[element.id] = Order(
            ordersItems: items,
            userId: element.data()["userId"],
            phoneNumber: element.data()["PhoneNumber"],
            location: element.data()["location"],
            id: element.id,
            orderType: type,
            totalPrice: element.data()["totalPrice"]);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }

    return [..._orders.values];
  }

  Future getOrdersForAdminsByType(OrderTypeEnum type) async {
    final String orderType = ordersTypeEnumToStringE[type]!;
    try {
      _orders.clear();
      final orders = await db.collection(orderType).get();
      for (var element in orders.docs) {
        final List<OrderItem> items = [];

        for (var e in (element.data()["orderItems"] as List<dynamic>)) {
          items.add(OrderItem(
              productId: e["productId"],
              quantity: e["quantity"],
              title: e["title"],
              price: e["price"],
              imageUrl: e["imageUrl"],
              size: e["size"]));
        }

        _orders[element.id] = Order(
            ordersItems: items,
            userId: element.data()["userId"],
            phoneNumber: element.data()["PhoneNumber"],
            location: element.data()["location"],
            id: element.id,
            orderType: type,
            totalPrice: element.data()["totalPrice"]);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }

    return [..._orders.values];
  }

  //  opreation on one order
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
        "title": e.title,
        "quantity": e.quantity,
        "size": e.size,
        "productId": e.productId
      };
    }).toList();
    try {
      final neworder = await db.collection("orderInProgres").add({
        "orderItems": items,
        "userId": userId,
        "PhoneNumber": phoneNumber,
        "totalPrice": totalPrice,
        "location": location,
        "createdAt": DateTime.now().toIso8601String(),
      });

      await db
          .collection("users")
          .doc(userId)
          .update({"phoneNumber": phoneNumber, "location": location});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cahngeOrderType({
    required OrderTypeEnum newtype,
    required String orderId,
    required OrderTypeEnum oldType,
  }) async {
    try {
      final order = await db
          .collection(ordersTypeEnumToStringE[oldType]!)
          .doc(orderId)
          .get();

      await db.collection(ordersTypeEnumToStringE[newtype]!).add({
        "orderItems": order.data()!["orderItems"],
        "userId": order.data()!["userId"],
        "PhoneNumber": order.data()!["PhoneNumber"],
        "totalPrice": order.data()!["totalPrice"],
        "location": order.data()!["location"]
      });

      await db
          .collection(ordersTypeEnumToStringE[oldType]!)
          .doc(orderId)
          .delete();

      _orders.remove(orderId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
