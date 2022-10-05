import 'dart:math';

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
        height: min(MediaQuery.of(context).size.height * .7,
            MediaQuery.of(context).size.height * 1.3),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * .8,
                height: 45,
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
            
                    ProductQuntity.quetity.value = 0;
            
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "تمت اضافة المنتج الي العربه",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                CartScreen.routeName);
                                      },
                                      child: const Text(
                                        "الذهاب الي العربه",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "متابعة التسوق",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ))
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const Text("اطلب الأن" , style: TextStyle(fontWeight: FontWeight.bold),),
                ),
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
