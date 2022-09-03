import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_size.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_discription.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_price.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_quntity.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_type.dart';

class ProductScreenDetail extends StatelessWidget {
  const ProductScreenDetail({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {

    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: const EdgeInsets.only(bottom: 100),
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(44, 7, 7, 1),
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
            const ProductQuntity(),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
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
