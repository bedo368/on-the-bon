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
        title: Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width,
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        background: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Hero(
              tag: id,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
