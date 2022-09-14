import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/global_widgets/confirm_dialog.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/edit_product_screen/edit_product_screen.dart';
import 'package:provider/provider.dart';

class ProductManageCard extends StatelessWidget {
  const ProductManageCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier(false);
    return Card(
      color: Theme.of(context).primaryColor,
      child: Row(textDirection: TextDirection.rtl, children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * .25,
          height: 70,
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/product_placeholder.png",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 90,
                    height: 25,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 226, 224, 224)),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              EditProductScreen.routeName,
                              arguments: {"id": product.id});
                        },
                        child: const Text(
                          'تعديل',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    width: 60,
                    height: 25,
                    child: ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, value, child) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  disabledBackgroundColor: Colors.grey),
                              onPressed: value
                                  ? null
                                  : () async {
                                      try {
                                        isLoading.value = true;
                                        await showMyDialog(
                                            context: context,
                                            title: "حذف المنتج",
                                            content:
                                                "حذف المنتج من قائمه المنتجات",
                                            onConfirm: () async {
                                              await Provider.of<Products>(
                                                      context,
                                                      listen: false)
                                                  .deleteProductById(product);
                                              isLoading.value = false;
                                            },
                                            onCancel: () {
                                              isLoading.value = false;
                                            });
                                      } catch (e) {
                                        rethrow;
                                      }
                                    },
                              child: value
                                  ? const Center(
                                      child: SpinKitChasingDots(
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                  : const Text(
                                      'حذف',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ));
                        }),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
