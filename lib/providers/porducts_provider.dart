import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/type_enum/types.dart';

class Products with ChangeNotifier {
  final ProductList _productList = {};

  get products {
    return {..._productList};
  }
}
