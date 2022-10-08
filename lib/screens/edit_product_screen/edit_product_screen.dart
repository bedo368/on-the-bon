import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/edit_product_screen/widets/edit_product_form.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  static String routeName = "/edit-product";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              "اضافة منتج",
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
      ),
    );
  }
}
