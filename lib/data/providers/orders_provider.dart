import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/data/models/order_item.dart';
import 'package:on_the_bon/data/providers/cart_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Orders with ChangeNotifier {
  final Map<String, Order> _orders = {};

  Order currOrder = Order(
      ordersItems: [],
      userId: "",
      phoneNumber: "",
      location: '',
      id: "",
      orderType: OrderTypeEnum.orderInProgres,
      totalPrice: 2,
      createdAt: DateTime.now());

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
            createdAt: (element.data()["createdAt"] as Timestamp).toDate(),
            deliverdAt: element.data()["deliverdAt"] != null
                ? (element.data()["deliverdAt"] as Timestamp).toDate()
                : null,
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
      final orders = await db
          .collection(orderType)
          .orderBy("createdAt", descending: false)
          .limit(50)
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
            createdAt: (element.data()["createdAt"] as Timestamp).toDate(),
            deliverdAt: element.data()["deliverdAt"] != null
                ? (element.data()["deliverdAt"] as Timestamp).toDate()
                : null,
            totalPrice: element.data()["totalPrice"]);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }

    return [..._orders.values];
  }

  //  opreation on one order
  Future<String> addOrder({
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
      final order =  await db.collection("orderInProgres").add({
        "orderItems": items,
        "userId": userId,
        "PhoneNumber": phoneNumber,
        "totalPrice": totalPrice,
        "location": location,
        "createdAt": DateTime.now(),
      });
      return order.id; 
      
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
        "location": order.data()!["location"],
        "createdAt": order.data()!["createdAt"],
        "deliverdAt": DateTime.now(),
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

  Future<void> getOrderById(String id) async {
    currOrder = Order(
        ordersItems: [],
        userId: "",
        phoneNumber: "",
        location: '',
        id: "",
        orderType: OrderTypeEnum.orderInProgres,
        totalPrice: 2,
        createdAt: DateTime.now());
    notifyListeners();
    final order = await FirebaseFirestore.instance
        .collection("orderInProgres")
        .doc(id)
        .get();
    final List<OrderItem> items = [];

    for (var e in (order.data()!["orderItems"] as List<dynamic>)) {
      items.add(OrderItem(
          productId: e["productId"],
          quantity: e["quantity"],
          title: e["title"],
          price: e["price"],
          imageUrl: e["imageUrl"],
          size: e["size"]));
    }
    currOrder = Order(
        userId: order.data()!['userId'],
        createdAt: (order.data()!['createdAt'] as Timestamp).toDate(),
        id: order.id,
        location: order.data()!['location'],
        totalPrice: order.data()!['totalPrice'],
        phoneNumber: order.data()!['PhoneNumber'],
        orderType: OrderTypeEnum.orderInProgres,
        ordersItems: items);
    notifyListeners();
  }
}
