import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
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

    final Product product =
        Provider.of<Products>(context, listen: false).fetchProductById(id: id);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: ChangeNotifierProvider.value(
          value: product,
          child: CustomScrollView(
            key: GlobalKey(),
            slivers: [
              ProductAppBar(
                  id: product.id,
                  imageUrl: product.imageUrl,
                  title: product.title,
                  isFav: product.isFav),
              ProductScreenDetail(
                product: product,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
