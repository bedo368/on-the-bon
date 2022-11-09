import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/global_widgets/animated_widgets/animated_heart.dart';
import 'package:on_the_bon/screens/home_screen/widgets/custom_clip_path.dart';
import 'package:provider/provider.dart';

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
        Consumer<Product>(builder: (context, v, c) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                      child: AnimatedHeart(
                    isFav: v.isFav,
                  ))),
            ),
          );
        })
      ],
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(right: 10, bottom: 10),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  color: const Color.fromARGB(104, 255, 255, 255),
                  padding: const EdgeInsets.only(left: 15, right: 2),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        background: ClipPath(
          clipper: WaveClip(),
          child: SizedBox(
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
      ),
    );
  }
}
