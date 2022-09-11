import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class Order {
  final List<CartItem> ordersItems;
  final String userId;
  final String phoneNumber;
  final String location;
  final String id;
  final OrderTypeEnum orderType;
  final double totalPrice;

  Order({
    required this.ordersItems,
    required this.userId,
    required this.phoneNumber,
    required this.location,
    required this.id,
    required this.orderType,
    required this.totalPrice,
  });

  
}
