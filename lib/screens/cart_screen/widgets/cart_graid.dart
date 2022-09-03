import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/cart_item.dart';

class CartGraid extends StatelessWidget {
  const CartGraid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CartItemWidget();
      },
      itemCount: 5,
    );
  }
}
