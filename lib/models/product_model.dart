import 'package:on_the_bon/type_enum/enums.dart';

class Product {
  final String name;
  final String id;
  final Map<String,String> price;
  final String photo;
  final String description;
  final ProductType type;
  final ProductSize size;
  final bool isFavorite;

  Product({
    required this.name,
    required this.id,
    required this.description,
    required this.price,
    required this.photo,
    required this.type,
    required this.size,
    required this.isFavorite,
  });
}
