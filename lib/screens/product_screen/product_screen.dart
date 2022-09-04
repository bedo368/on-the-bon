import 'package:flutter/material.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_app_bar.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_quntity.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_screen_detail.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static String routeName = "/product-screen";

  @override
  Widget build(BuildContext context) {
    ProductQuntity.quetity.value = 1;
    String id = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)['id'] as String;
    String type = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)['type'] as String;
    final Product product = Provider.of<Products>(context)
        .fetchProductByTypeAndId(id: id, type: type);

    return Scaffold(
      body: CustomScrollView(
        key: GlobalKey(),
        slivers: [
          ProductAppBar(
            id: product.id,
            imageUrl: product.imageUrl,
            title: product.title,
          ),
          ProductScreenDetail(
            product: product,
          ),
        ],
      ),
    );
  }
}
