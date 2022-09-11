import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/product_manage_screen/widgets/product_manage_card.dart';
import 'package:provider/provider.dart';

class ProductManageGraid extends StatelessWidget {
  const ProductManageGraid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).allProducts;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: MediaQuery.of(context).size.width * .8,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: ProductManageCard(
                product: products[index],
                key: ValueKey(products[index].id),
              ),
            );
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}
