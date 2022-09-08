import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/add_edit_product_screens/widets/add_product_form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  static String routeName = "/add-product";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(right: 10),
            child: const Text(
              "اضافة منتج",
              textAlign: TextAlign.end,
            ),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: const [
              AddProductForm(),
            ],
          ),
        ),
      ),
    );
  }
}
