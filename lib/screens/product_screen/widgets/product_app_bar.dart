import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);
  final String title;
  final String imageUrl;
  final String id;

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
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.heart,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
              title,
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
            tag: id,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
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
