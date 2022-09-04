class OrderItem {
  final String id;
  final String productId;
  final double quantity;
  final String title;
  final double price;
  final String size;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.title,
    required this.price,
    required this.size,
    required this.productId,
  });
}
