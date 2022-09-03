import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/bottom_card.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.currentProduct, {Key? key}) : super(key: key);
  final Product currentProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductScreen.routeName,
                          arguments: {
                            "id": currentProduct.id,
                            "type": currentProduct.type
                          });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      child: Card(
                          margin: const EdgeInsets.only(bottom: 0),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                          color: const Color.fromRGBO(249, 242, 246, 1),
                          child: Column(
                            children: [Container()],
                          )),
                    ),
                  ),
                  BottomCard(
                    id: currentProduct.id,
                    title: currentProduct.title,
                    sizePrice: currentProduct.sizePrice,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductScreen.routeName,
                  arguments: {
                    "id": currentProduct.id,
                    "type": currentProduct.type
                  });
            },
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Hero(
                tag: currentProduct.id,
                child: Image.network(
                  currentProduct.imageUrl,
                  height: 170,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
