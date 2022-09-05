import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/order_widget.dart';
import 'package:on_the_bon/screens/orders_screen/orders_button.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static String routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "قائمه طلباتي",
            textAlign: TextAlign.end,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OrdersButton(),
            Container(
              width: MediaQuery.of(context).size.width*.9,
              margin: const EdgeInsets.only(top: 40),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderWidget(
                    order: ordersData.orders[index],
                  );
                },
                itemCount: ordersData.orders.length,
              ),
            )
          ],
        ),
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
