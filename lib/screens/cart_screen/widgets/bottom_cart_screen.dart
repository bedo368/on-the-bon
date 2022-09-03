import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreenBottom extends StatelessWidget {
  const CartScreenBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    return cartData.items.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: MediaQuery.of(context).size.width * .9,
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "اجمالي الطلب : ${cartData.totalPrice.toInt()} جنيه ",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("اطلب الان"),
                ),
              )
            ]),
          )
        : Container();
  }
}
