import 'package:on_the_bon/data/models/order_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Order {
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
}
