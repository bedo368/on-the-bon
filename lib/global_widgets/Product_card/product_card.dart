import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/global_widgets/Product_card/bottom_card.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(this.currentProduct, {Key? key}) : super(key: key);
  final Product currentProduct;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  SMIInput<bool>? isFavoriteInput;
  Artboard? isFavoriteArtboard;
  @override
  void initState() {
    rootBundle.load("assets/animation/heart.riv").then((value) {
      final file = RiveFile.import(value);
      final artBoard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
        artBoard,
        "State Machine 1",
      );
      if (controller != null) {
        artBoard.addController(controller);
        isFavoriteInput = controller.findInput("isFaivorite");
        isFavoriteArtboard = artBoard;
      }
      setState(() {
        isFavoriteInput!.value = widget.currentProduct.isFav;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                spreadRadius: 2,

                blurRadius: 20,
                offset: const Offset(2, 4), // changes position of shadow
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
                      if (isFavoriteArtboard != null)
                        Positioned(
                          right: 1,
                          top: 2,
                          child: Consumer<Product>(builder: (context, v, c) {
                            isFavoriteInput!.value = v.isFav;
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
                                      child: Rive(
                                        artboard: isFavoriteArtboard!,
                                        fit: BoxFit.cover,
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