import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ProductAppBar extends StatefulWidget {
  const ProductAppBar({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.id,
    required this.isFav,
  }) : super(key: key);
  final String title;
  final String imageUrl;
  final String id;
  final bool isFav;

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar> {
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
        isFavoriteInput!.value = widget.isFav;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          )),
      actions: [
        if (isFavoriteArtboard != null)
          Positioned(
            right: 1,
            top: 15,
            child: Consumer<Product>(builder: (context, v, c) {
              isFavoriteInput!.value = v.isFav;
              return ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  width: 45,
                  height: 35,
                  child: GestureDetector(
                      onTap: () async {
                        try {
                          await Provider.of<Product>(context, listen: false)
                              .updateProductFavoriteState(widget.id);
                          // ignore: use_build_context_synchronously
                          Provider.of<Products>(context, listen: false)
                              .updateUserFavoriteForProducts(widget.id);
                        } catch (e) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          )
      ],
      backgroundColor: const Color.fromRGBO(249, 242, 246, 1),
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            color: const Color.fromARGB(104, 255, 255, 255),
            padding: const EdgeInsets.only(left: 15, right: 2),
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        background: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: widget.id,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset(
                  "assets/images/product_placeholder.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
