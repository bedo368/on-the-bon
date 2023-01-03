import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_type_element.dart';
import 'package:on_the_bon/type_enum/enums.dart';
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
    return ValueListenableBuilder<String>(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      // reverse: true,
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      // controller: ScrollController(),
                      itemBuilder: (context, index) {
                        final List<String> types =
                            productsStringToType.keys.toList();
                        // Provider.of<Products>(context, listen: false)
                        //     .types
                        //     .keys
                        //     .toList()
                        //     .reversed
                        //     .toList();
                        return TypeElement(
                          typeName: types[index],
                        );
                      },
                      itemCount: Provider.of<Products>(context, listen: false)
                          .types
                          .keys
                          .length,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
