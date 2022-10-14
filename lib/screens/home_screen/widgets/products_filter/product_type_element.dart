import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/floating_sky_for_faivorite_element.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class TypeElement extends StatefulWidget {
  const TypeElement({
    Key? key,
    required this.index,
    required this.v,
  }) : super(key: key);

  final int index;

  final ProductsTypeEnum v;

  @override
  State<TypeElement> createState() => _TypeElementState();
}

class _TypeElementState extends State<TypeElement> {
  final List<String> types = productsStringToType.keys.toList();

  SMIInput<bool>? isSelectedInput;
  Artboard? isSelectedArtboard;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.only(bottom: 3),
      child: Stack(
        textDirection: TextDirection.rtl,
        alignment: AlignmentDirectional.center,
        children: [
          GestureDetector(
            onTap: () {
              final productData = Provider.of<Products>(context, listen: false);
              if (HomeScreen.productType.value !=
                  productsStringToType[types[widget.index]]) {
                HomeScreen.productType.value =
                    productsStringToType[types[widget.index]] as ProductsTypeEnum;
                productData.setType(productsStringToType[types[widget.index]]
                    as ProductsTypeEnum);
                if (isSelectedInput != null) {
                  setState(() {
                    isSelectedInput!.value = HomeScreen.productType.value ==
                            productsStringToType[types[widget.index]]
                        ? true
                        : false;
                  });
                }
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: widget.v == productsStringToType[types[widget.index]]
                        ? Theme.of(context).colorScheme.secondary
                        : const Color.fromARGB(255, 224, 223, 223),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Text(
                          types[widget.index],
                          style: TextStyle(
                              color: widget.v ==
                                      productsStringToType[types[widget.index]]
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 50, height: 50, child: Floatingsky(index: widget.index)),
            ),
          ),
        ],
      ),
    );
  }
}
