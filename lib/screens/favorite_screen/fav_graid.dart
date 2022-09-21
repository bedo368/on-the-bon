import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> productList =
        Provider.of<Products>(context).getFavProducts;

    return AnimatedSwitcher(
      transitionBuilder: (child, animation) => SlideTransition(
          position: animation.drive(Tween<Offset>(
              begin: const Offset(-1, 0), end: const Offset(0, 0))),
          child: child),
      duration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeIn,
      child: productList.isEmpty
          ? const Center(
              child: Text("عذرا المنتجات غير متاحه الان"),
            )
          : ListView.builder(
              key: ValueKey(productList.first.id),
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
            ),
    );
  }
}
