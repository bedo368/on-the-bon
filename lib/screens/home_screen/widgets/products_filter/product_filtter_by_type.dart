import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_type_element.dart';
import 'package:provider/provider.dart';

class ProdcutsFiltterByType extends StatefulWidget {
  const ProdcutsFiltterByType({
    Key? key,
  }) : super(key: key);

  @override
  State<ProdcutsFiltterByType> createState() => _ProdcutsFiltterByTypeState();
}

class _ProdcutsFiltterByTypeState extends State<ProdcutsFiltterByType> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ValueListenableBuilder<String>(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
          return SizedBox(
            width: mediaQuery.size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: mediaQuery.size.width,
                    height: 110,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: mediaQuery.size.width,
                          height: 110,
                          child: ListView.builder(
                            reverse: true,
                            
                            scrollDirection: Axis.horizontal,
                            controller:
                                ScrollController(initialScrollOffset: 1),
                            itemBuilder: (context, index) {
                              final List<String> types =
                                  Provider.of<Products>(context, listen: false)
                                      .types
                                      .keys
                                      .toList();
                              return TypeElement(
                                typeName: types[index],
                              );
                            },
                            itemCount:
                                Provider.of<Products>(context, listen: false)
                                    .types
                                    .keys
                                    .length,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
