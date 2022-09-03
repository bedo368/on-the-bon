import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemImage extends StatelessWidget {
  const CartItemImage({
    Key? key,
    required this.imageUrl,
    required this.quntity,
    required this.id,
  }) : super(key: key);
  final String imageUrl;
  final double quntity;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: Column(
        children: [
          Center(child: Image.network(imageUrl)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<Cart>(context, listen: false).decreaseItemBy1(id);
                },
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(3),
                            topLeft: Radius.circular(3))),
                    child: const Center(
                      child: Icon(
                        Ionicons.remove,
                        color: Colors.white,
                      ),
                    )),
              ),
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(child: Text("$quntity"))),
              GestureDetector(
                onTap: () {
                  Provider.of<Cart>(context, listen: false).increaseItemBy1(id);
                },
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(3),
                            topRight: Radius.circular(3))),
                    child: const Center(
                      child: Icon(
                        Ionicons.add,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
