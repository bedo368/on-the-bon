import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatelessWidget {
  const ProductGraid({Key? key, required this.onScroll}) : super(key: key);
  final Function(double) onScroll;

  @override
  Widget build(BuildContext context) {
    final gridController = ScrollController();

    return Consumer<Products>(
      builder: (context, value, c) {
        gridController.addListener(() {
          onScroll(gridController.offset);
        });
        final productList = value.getProductWithType;

        return AnimatedSwitcher(
            transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: const Offset(-1, 0), end: const Offset(0, 0))),
                child: child),
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            child: Container(
              // constraints: BoxConstraints(
              //     minHeight: 500,
              //     maxHeight: mediaQuery.size.height),
              key: ValueKey(productList.first.id),
              child: productList.isEmpty
                  ? const Center(
                      child: Text("عذرا المنتجات غير متاحه الان"),
                    )
                  : ListView.builder(
                      controller: gridController,
                     
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: index == productList.length - 1 ? 200 : 0),
                          child: ChangeNotifierProvider.value(
                            value: productList[index],
                            child: ProductCard(
                              productList[index],
                              key: ValueKey(productList.first.id),
                            ),
                          ),
                        );
                        // return Container();
                      },
                      itemCount: productList.length,
                    ),
            ));
      },
    );
  }
}
