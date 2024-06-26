import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/confirm_dialog.dart';
import 'package:on_the_bon/data/providers/cart_item.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {Key? key, required this.cartItem, required this.cartItemId})
      : super(key: key);
  final CartItem cartItem;
  final String cartItemId;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cartData = Provider.of<Cart>(context, listen: false);
    return Container(
      width: mediaQuery.size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 120,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                child: CachedNetworkImage(
                  imageUrl: cartItem.imageUrl,
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
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Text(
                            cartItem.size,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Text(
                              "${cartItem.price}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Text(
                            "جنيه ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartData.increaseItemBy1(cartItemId);
                        },
                        child: Container(
                          width: 30,
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(3),
                                  bottomRight: Radius.circular(3))),
                          child: const Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 25,
                        width: 35,
                        child: Center(
                            child: Text(cartItem.quantity.toInt().toString())),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (cartItem.quantity <= 1) {
                            await showConfirmDialog(
                                confirmText: "حذف",
                                cancelText: "الغاء",
                                context: context,
                                title: 'حذف من عربة التسوق',
                                content: 'هل تريد حذف المنتج من العربه ',
                                onConfirm: () {
                                  cartData.decreaseItemBy1(cartItemId);
                                },
                                onCancel: () {});
                            return;
                          }
                          cartData.decreaseItemBy1(cartItemId);
                        },
                        child: Container(
                          height: 25,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  bottomLeft: Radius.circular(3))),
                          child: const Center(
                              child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await showConfirmDialog(
                                confirmText: "حذف",
                                cancelText: "الغاء",
                                context: context,
                                title: 'حذف من عربة التسوق',
                                content: 'هل تريد حذف المنتج من العربه ',
                                onConfirm: () {
                                  Provider.of<Cart>(context, listen: false)
                                      .removeItem(cartItemId);
                                },
                                onCancel: () {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
