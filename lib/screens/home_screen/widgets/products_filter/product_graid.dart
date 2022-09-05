import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/type_enum/types.dart';

class ProductGraid extends StatelessWidget {
  final List<Product> productsList;
  const ProductGraid(this.productsList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return ProductCard(
          productsList[index],
          key: Key(productsList[index].id),
        );
        // return Container();
      },
      itemCount: productsList.length,
    );
  }
}
