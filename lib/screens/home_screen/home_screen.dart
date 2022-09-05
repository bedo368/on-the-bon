import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_subtype.dart';

import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_type.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_graid.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<ProductsType> productType =
      ValueNotifier<ProductsType>(ProductsType.food);

  @override
  Widget build(BuildContext context) {
    Provider.of<Products>(context).fetchProductAsync();
    final products = Provider.of<Products>(context).getProductWithType();
    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      drawer: const Drawer(
        backgroundColor: Colors.amber,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          "On The Bon",
          style: TextStyle(fontFamily: "RockSalt"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProdcutsFiltterByType(),
            const ProductsFillterBySubType(),
            Container(
                margin: const EdgeInsets.only(top: 40),
                child: ProductGraid(products))
          ],
        ),
      ),
    );
  }
}
