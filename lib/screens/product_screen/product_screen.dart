import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_app_bar.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_screen_detail.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static String routeName = "/product-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: GlobalKey(),
        slivers: const [
          ProductAppBar(),
          ProductScreenDetail(),
        ],
      ),
    );
  }
}
