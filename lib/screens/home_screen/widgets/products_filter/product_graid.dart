import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Products>(context).getProductWithType;

    return AnimatedSwitcher(
      transitionBuilder: (child, animation) => SlideTransition(
          position: animation.drive(Tween<Offset>(
              begin: const Offset(-1, 0), end: const Offset(0, 0))),
          child: child),
      duration: const Duration(milliseconds: 300),
      child: productList.isEmpty
          ? const Center(
              child: Text("عذرا المنتجات غير متاحه الان"),
            )
          : ListView.builder(
              key: ValueKey(productList.first),
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return ProductCard(
                  productList[index],
                  key: Key(productList[index].id),
                );
                // return Container();
              },
              itemCount: productList.length,
            ),
    );
  }
}
