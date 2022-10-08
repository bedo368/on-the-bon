import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class ProductGraid extends StatefulWidget {
  const ProductGraid({Key? key}) : super(key: key);

  @override
  State<ProductGraid> createState() => _ProductGraidState();
}

class _ProductGraidState extends State<ProductGraid> {
  final ScrollController gridController = ScrollController();
  double topContainer = 0;
  @override
  void initState() {
    // TODO: implement initState

    gridController.addListener(() {
      double value = gridController.offset / 310;
      HomeScreen.isProductHomeScreenGridScroll.value =
          gridController.offset > 50;
      setState(() {
        topContainer = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, value, c) {
        final productList = value.getProductWithType;

        return AnimatedSwitcher(
            transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: const Offset(-1, 0), end: const Offset(0, 0))),
                child: child),
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            child: Container(
              constraints: BoxConstraints(
                  minHeight: 500,
                  maxHeight: MediaQuery.of(context).size.height),
              key: ValueKey(productList.first.imageUrl),
              child: productList.isEmpty
                  ? const Center(
                      child: Text("عذرا المنتجات غير متاحه الان"),
                    )
                  : ListView.builder(
                      controller: gridController,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        double scale = 1;
                        double opacity = 1;

                        if (topContainer > .5) {
                          scale = index + 1.3 - topContainer;
                          opacity = index + 1.3 - topContainer;

                          if (scale < 0) {
                            scale = 0;
                            opacity = 0;
                          } else if (scale > 1) {
                            scale = 1;
                            opacity = 1;
                          }

                          if (index == topContainer.toInt() + 1) {
                            scale = 1.05;
                          }
                        }

                        return Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  index == productList.length - 1 ? 130 : 0),
                          child: Opacity(
                            opacity: opacity,
                            child: Transform(
                              alignment: Alignment.bottomCenter,
                              transform: Matrix4.identity()
                                ..scale(scale, scale),
                              child: ChangeNotifierProvider.value(
                                value: productList[index],
                                child: ProductCard(
                                  productList[index],
                                  key: ValueKey(productList.first.id),
                                ),
                              ),
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
