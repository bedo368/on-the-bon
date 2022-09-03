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
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(ProductScreen.routeName,
                  //         arguments: {
                  //           "id": currentProduct.id,
                  //           "type": currentProduct.type
                  //         });
                  //   },
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 140,
                  //     child: Card(
                  //         margin: const EdgeInsets.only(bottom: 0),
                  //         shape: const RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(10),
                  //           topRight: Radius.circular(10),
                  //         )),
                  //         color: Color.fromARGB(255, 255, 255, 255),
                  //         child: Column(
                  //           children: [Container()],
                  //         )),
                  //   ),
                  // ),
                  Card(
                    margin: const EdgeInsets.only(top: 0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ProductScreen.routeName,
                            arguments: {
                              "id": currentProduct.id,
                              "type": currentProduct.type
                            });
                      },
                      child: Hero(
                        tag: currentProduct.id,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            currentProduct.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BottomCard(
                    id: currentProduct.id,
                    title: currentProduct.title,
                    sizePrice: currentProduct.sizePrice,
                    imagUrl: currentProduct.imageUrl,
                    type: currentProduct.type,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
