import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/navigation_bar/navigation_bar.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/bottom_cart_screen.dart';
import 'package:on_the_bon/screens/cart_screen/widgets/cart_graid/cart_graid.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ButtomNavigationBar(
        key:  GlobalKey(debugLabel: "key"),
        routeName: CartScreen.routeName,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "عربة التسوق",
              textAlign: TextAlign.end,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(bottom: 80),
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (cartData.cartItems.isNotEmpty) const CartGraid(),
                const CartScreenBottom(),
              ],
            ))),
      ),
    );
  }
}
