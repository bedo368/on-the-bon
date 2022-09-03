import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/cart_graid/bottom_card_item.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CartItemDetail(cartItem: cartItem),
          CartItemImage(
            imageUrl: cartItem.imageUrl,
            quntity: cartItem.quantity,
            id: cartItem.id,
          ),
        ],
      ),
    );
  }
}

class CartItemDetail extends StatelessWidget {
  const CartItemDetail({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 120,
      width: MediaQuery.of(context).size.width * .6,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width,
          child: Text(
            cartItem.title,
            style: const TextStyle(
                fontFamily: "permanentMarker",
                fontSize: 20,
                color: Colors.white),
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width,
          child: Text(
            "${cartItem.price} : السعر ",
            style: const TextStyle(
                fontFamily: "permanentMarker",
                fontSize: 20,
                color: Colors.white),
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 30,
                  margin: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            ProductScreen.routeName,
                            arguments: {
                              "id": cartItem.id,
                              "type": cartItem.type
                            });
                      },
                      child: const Text(
                        "عرض المنتج",
                      ))),
              SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeItem(cartItem.id);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text("حذف"),
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
