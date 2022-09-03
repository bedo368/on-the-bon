class Product {
  final String id;
  final String title;
  final String discription;
  final Map<String, double> sizePrice;
  final String type;
  final String subType;
  final String imageUrl;
  const Product(
      {required this.id,
      required this.title,
      required this.discription,
      required this.sizePrice,
      required this.type,
      required this.subType,
      required this.imageUrl});
}
