import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_size.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_discription.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_price.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_quntity.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_type.dart';
import 'package:provider/provider.dart';

class ProductScreenDetail extends StatelessWidget {
  const ProductScreenDetail({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    ProductSize.selectedSize.value = product.sizePrice.keys.first;
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: const EdgeInsets.only(bottom: 100),
        height: MediaQuery.of(context).size.height * .7,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            ProductType(
              type: product.type,
              subType: product.subType,
            ),
            PrdocutDiscription(
              discription: product.discription,
            ),
            const CustomDivder(),
            ProductQuntity(
              id: product.id,
            ),
            const CustomDivder(),
            if (product.sizePrice.length > 1)
              ProductSize(
                sizePrice: product.sizePrice,
              ),
            if (product.sizePrice.length > 1) const CustomDivder(),
            ProductPrice(
              price: product.sizePrice,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * .8,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Cart>(context, listen: false)
                      .addItemToCartWithQuntity(
                          title: product.title,
                          id: product.id,
                          price: product
                                  .sizePrice[ProductSize.selectedSize.value] ??
                              product.sizePrice.values.first,
                          imageUrl: product.imageUrl,
                          type: product.type,
                          size: ProductSize.selectedSize.value,
                          quntity: ProductQuntity.quetity.value);
                  Navigator.of(context)
                      .pushReplacementNamed(CartScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text("اطلب الأن"),
              ),
            )
          ],
        ),
      )
    ]));
  }
}

class CustomDivder extends StatelessWidget {
  const CustomDivder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * .6,
      child: const Divider(
        thickness: 3,
        color: Colors.white,
      ),
    );
  }
}
