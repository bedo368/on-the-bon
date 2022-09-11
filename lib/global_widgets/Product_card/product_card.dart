import 'package:cached_network_image/cached_network_image.dart';
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
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width >= 500
              ? 300
              : MediaQuery.of(context).size.width * .8,
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(top: 0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductScreen.routeName, arguments: {
                      "id": currentProduct.id,
                    });
                  },
                  child: SizedBox(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: currentProduct.id,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: currentProduct.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(
                                "assets/images/product_placeholder.png",
                                fit: BoxFit.cover,
                              );
                            },
                          )),
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
    );
  }
}


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