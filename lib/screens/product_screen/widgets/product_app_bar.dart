import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.heart_broken,
              size: 40,
              color: Colors.black,
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
        background: Image.network(imageUrl),
      ),
    );
  }
}
