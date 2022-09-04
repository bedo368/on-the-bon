import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/cart_item.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/cart_graid/cart_item.dart';
import 'package:provider/provider.dart';

class CartGraid extends StatelessWidget {
  const CartGraid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final cartItmesKeys = cartData.cartItems.keys.toList();
    final Map<String, CartItem> itemsList = cartData.cartItems;

    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "قائمة المشتريات",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return CartItemWidget(
                cartItemId: cartItmesKeys[index],
                cartItem: CartItem(
                    id: itemsList[cartItmesKeys[index]]!.id,
                    title: itemsList[cartItmesKeys[index]]!.title,
                    price: itemsList[cartItmesKeys[index]]!.price,
                    imageUrl: itemsList[cartItmesKeys[index]]!.imageUrl,
                    quantity: itemsList[cartItmesKeys[index]]!.quantity,
                    type: itemsList[cartItmesKeys[index]]!.type,
                    size: itemsList[cartItmesKeys[index]]!.size),
              );
            },
            itemCount: itemsList.length,
          ),
        ],
      ),
    );
  }
}
