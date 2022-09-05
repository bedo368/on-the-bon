class OrderItem {
  final String productId;
  final double quantity;
  final String title;
  final double price;
  final String size;
  final String imageUrl;
  final String type;

  const OrderItem({
    required this.productId,
    required this.title,
    required this.type,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    required this.size,
  });
}
