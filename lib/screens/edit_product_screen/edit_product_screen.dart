import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/edit_product_screen/widets/edit_product_form.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  static String routeName = "/edit-product";

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: const [
                EditProductFrom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
