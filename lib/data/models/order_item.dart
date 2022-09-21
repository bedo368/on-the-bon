class OrderItem {
  final String productId;
  final double quantity;
  final String title;
  final double price;
  final String size;
  final String imageUrl;

  const OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity ,
    required this.size,
  });
}
