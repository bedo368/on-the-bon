import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
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
                padding: const EdgeInsets.all(10),
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
              Form(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 40, top: 10),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        decoration: cartInput("رقم الهاتف"),
                      ),
                    ),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration: cartInput("العنوان"),
                    ),
                  ],
                ),
              )),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OrdersScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 5)),
                  child: const Text("تأكيد الطلب"),
                ),
              )
            ]),
          )
        : Container();
  }
}

InputDecoration cartInput(String label) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      fillColor: const Color.fromARGB(255, 247, 244, 244),
      filled: true,
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ));
}
