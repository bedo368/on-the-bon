import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_type_element.dart';
import 'package:on_the_bon/type_enum/enums.dart';

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
    return ValueListenableBuilder<ProductsTypeEnum>(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 110,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      
                      child: Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return TypeElement(
                                index: index,
                                v: v,
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
            ),
          );
        });
  }
}
