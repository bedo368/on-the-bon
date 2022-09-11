import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/product_search_delgate.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/add_product_screens/add_product_screen.dart';
import 'package:on_the_bon/screens/edit_product_screen/edit_product_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/widgets/product_manage_graid.dart';
import 'package:provider/provider.dart';

class ProductManageScreen extends StatelessWidget {
  const ProductManageScreen({Key? key}) : super(key: key);
  static String routeName = "/manage-products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Manage Products"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(
                    Provider.of<Products>(context, listen: false).allProducts,
                    (context, id, type) {
                      Navigator.of(context).pushNamed(
                          EditProductScreen.routeName,
                          arguments: {"id": id, "type": type});
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: const SingleChildScrollView(child: ProductManageGraid()),
    );
  }
}
