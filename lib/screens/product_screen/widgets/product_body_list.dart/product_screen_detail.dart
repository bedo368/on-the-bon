import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_size.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_discription.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_price.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_quntity.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_type.dart';

class ProductScreenDetail extends StatelessWidget {
  const ProductScreenDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        color: const Color.fromRGBO(44, 7, 7, 1),
        child: Column(
          children: [
            const ProductType(),
            const PrdocutDiscription(),
            const CustomDivder(),
            const ProductQuntity(),
            const CustomDivder(),
            const ProductSize(),
            const CustomDivder(),
            const ProductPrice(),
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
