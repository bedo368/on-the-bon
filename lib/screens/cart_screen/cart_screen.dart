import 'package:flutter/material.dart';

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
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
