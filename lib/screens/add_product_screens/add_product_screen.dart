import 'package:flutter/material.dart';

import 'package:on_the_bon/screens/add_product_screens/widets/add_product_forms.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  static String routeName = "/add-product";

  @override
  Widget build(BuildContext context) {
    // String id =
    //     (ModalRoute.of(context)!.settings.arguments as dynamic)['id'] ?? "";
    // String type =
    //     (ModalRoute.of(context)!.settings.arguments as dynamic)['type'] ?? "";
    // final Product currentPeoduct = Provider.of<Products>(context, listen: false)
    //     .fetchProductByTypeAndId(type: type, id: id);

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
                AddProductForm(
                    // currentPeoduct: currentPeoduct,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
