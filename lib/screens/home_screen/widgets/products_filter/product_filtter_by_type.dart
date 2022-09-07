
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
    final List<String> types = productsTypeToString.keys.toList();
    return ValueListenableBuilder(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
          return Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<Products>(builder: (context, v, c) {
                    return Text(
                      " النوع : ${v.getCurrentType}",
                      style: const TextStyle(fontSize: 23),
                      textAlign: TextAlign.right,
                    );
                  }),
                ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                HomeScreen.productType.value =
                                    productsTypeToString[types[index]]
                                        as ProductsType;
                                productData.setType(
                                    productsTypeToString[types[index]]
                                        as ProductsType);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: v == productsTypeToString[types[index]]
                                      ? Theme.of(context).colorScheme.secondary
                                      : const Color.fromARGB(255, 224, 223, 223),
                                ),
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Center(
                                  child: Text(
                                    types[index],
                                    style: TextStyle(
                                        color: v ==
                                                productsTypeToString[
                                                    types[index]]
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: productsTypeToString.length,
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
