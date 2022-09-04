import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/orders_screen/orders_button.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static String routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "قائمه طلباتي",
            textAlign: TextAlign.end,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Column(
        children: [
          OrdersButton(),
        ],
      ),
    );
  }
}

ButtonStyle customBotton() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      primary: Colors.transparent,
      shadowColor: Colors.transparent);
}
