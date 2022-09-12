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
    final List<CartItem> itemsList = cartData.cartItems;

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
                cartItemId: itemsList[index].id,
                cartItem: CartItem(
                    id: itemsList[index].id,
                    productId: itemsList[index].productId,
                    title: itemsList[index].title,
                    price: itemsList[index].price,
                    imageUrl: itemsList[index].imageUrl,
                    quantity: itemsList[index].quantity,
                    size: itemsList[index].size),
              );
            },
            itemCount: itemsList.length,
          ),
        ],
      ),
    );
  }
}
