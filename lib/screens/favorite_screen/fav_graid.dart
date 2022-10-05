import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, value, c) {
        final productList = value.getFavProducts;

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: productList[index],
              child: ProductCard(
                productList[index],
              ),
            );
            // return Container();
          },
          
          itemCount: productList.length,
        );
        
      },
    );
  }
}
