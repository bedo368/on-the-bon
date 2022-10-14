import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
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
    gridController.addListener(() {
      double value = gridController.offset / 310;

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
        final productList = value.getFavProducts;

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                controller: gridController,
                // shrinkWrap: true,
                // primary: false,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  double scale = 1;
                  double opacity = 1;

                  if (topContainer > .5) {
                    scale = index + 1.35 - topContainer;
                    opacity = index + 1.35 - topContainer;

                    if (scale < 0) {
                      scale = 0;
                      opacity = 0;
                    } else if (scale > 1) {
                      scale = 1;
                      opacity = 1;
                    }
                  }
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: index == productList.length - 1 ? 150 : 0),
                    child: Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..scale(scale, scale),
                        child: ChangeNotifierProvider.value(
                          value: productList[index],
                          child: ProductCard(
                            productList[index],
                          ),
                        ),
                      ),
                    ),
                  );
                  // return Container();
                },

                itemCount: productList.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
