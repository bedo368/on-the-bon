import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/data/models/order_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Order extends ChangeNotifier {
  final List<OrderItem> ordersItems;
  final String userId;
  final String phoneNumber;
  final String location;
  final String id;
  final OrderTypeEnum orderType;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime? deliverdAt;

  Order({
    required this.ordersItems,
    required this.userId,
    required this.phoneNumber,
    required this.location,
    required this.id,
    required this.orderType,
    required this.totalPrice,
    required this.createdAt,
    this.deliverdAt,
  });


  

  // Factory Order. ( String id ){}
}

class OrderFactory {
  static Future<Order> createOrder(String id) async {
    final order = await FirebaseFirestore.instance
        .collection("orderInProgres")
        .doc(id)
        .get()
        .then((order) {
      return Order(
          userId: order.data()!['userId'],
          createdAt: order.data()!['createdAt'],
          id: order.id,
          location: order.data()!['location'],
          totalPrice: order.data()!['totalPrice'],
          phoneNumber: order.data()!['phoneNumber'],
          orderType: OrderTypeEnum.orderInProgres,
          ordersItems: []);
    });

    return order;
  }
}
