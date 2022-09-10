import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class ProdcutsFiltterByType extends StatelessWidget {
  const ProdcutsFiltterByType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> types = productsStringToType.keys.toList();
    return ValueListenableBuilder(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
          return Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Container(
                  height: 65,
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final productData = Provider.of<Products>(
                                    context,
                                    listen: false);
                                if (HomeScreen.productType.value !=
                                    productsStringToType[types[index]]) {
                                  HomeScreen.productType.value =
                                      productsStringToType[types[index]]
                                          as ProductsTypeEnum;
                                  productData.setType(
                                      productsStringToType[types[index]]
                                          as ProductsTypeEnum);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: v == productsStringToType[types[index]]
                                      ? Theme.of(context).colorScheme.secondary
                                      : const Color.fromARGB(
                                          255, 224, 223, 223),
                                ),
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Center(
                                  child: Text(
                                    types[index],
                                    style: TextStyle(
                                        color: v ==
                                                productsStringToType[
                                                    types[index]]
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: productsStringToType.length,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
