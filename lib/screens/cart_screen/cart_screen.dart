import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/bottom_cart_screen.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/cart_graid/cart_graid.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "عربة التسوق",
              textAlign: TextAlign.end,
            )),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [CartGraid(), CartScreenBottom()],
          ))),
    );
  }
}
