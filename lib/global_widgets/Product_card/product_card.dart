import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/global_widgets/Product_card/bottom_card.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/global_widgets/animated_widgets/animated_heart.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(this.currentProduct, {Key? key}) : super(key: key);
  final Product currentProduct;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double op = .8;
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                spreadRadius: .2,
                

                blurRadius: 10,
                offset: const Offset(1, 1), // changes position of shadow
              ),
               BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                spreadRadius: .2,

                blurRadius: 10,
                offset: const Offset(-.1, 1), // changes position of shadow
              ),
            ],
          ),
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
                      "id": widget.currentProduct.id,
                    });
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: widget.currentProduct.id,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.currentProduct.imageUrl,
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
                      Positioned(
                        right: 1,
                        top: 2,
                        child: Consumer<Product>(builder: (context, v, c) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              width: 40,
                              height: 40,
                              child: GestureDetector(
                                  onTap: () async {
                                    try {
                                      final connection =
                                          await InternetConnectionChecker
                                                  .createInstance()
                                              .hasConnection;
                                      if (!connection) {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                dismissDirection:
                                                    DismissDirection
                                                        .startToEnd,
                                                duration:
                                                    Duration(seconds: 2),
                                                content: Text(
                                                  "هناك خطأ في الاتصال ",
                                                  textAlign:
                                                      TextAlign.center,
                                                )));

                                        return;
                                      }
                                      // ignore: use_build_context_synchronously
                                      await Provider.of<Product>(context,
                                              listen: false)
                                          .updateProductFavoriteState(
                                              widget.currentProduct.id);
                                      // ignore: use_build_context_synchronously
                                      Provider.of<Products>(context,
                                              listen: false)
                                          .updateUserFavoriteForProducts(
                                              widget.currentProduct.id);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "ناسف لم يتم اضافه المنتج للمفضلة حاول مجددا")));
                                    }
                                  },
                                  child: Center(
                                    child: AnimatedHeart(
                                      isFav: v.isFav,
                                    ),
                                  )),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              BottomCard(
                id: widget.currentProduct.id,
                title: widget.currentProduct.title,
                sizePrice: widget.currentProduct.sizePrice,
                imagUrl: widget.currentProduct.imageUrl,
                type: widget.currentProduct.type,
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