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
    required this.typeName,
  }) : super(key: key);


  final String typeName;

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
              if (HomeScreen.productType.value != widget.typeName) {
                HomeScreen.productType.value = widget.typeName;
                productData.setType(widget.typeName);
                if (isSelectedInput != null) {
                  setState(() {
                    isSelectedInput!.value =
                        HomeScreen.productType.value == widget.typeName
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
                    color: widget.typeName == HomeScreen.productType.value
                        ? Theme.of(context).primaryColor
                        : const Color.fromARGB(255, 224, 223, 223),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Text(
                          widget.typeName,
                          style: TextStyle(
                              color: widget.typeName ==
                                      HomeScreen.productType.value
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
                  width: 50,
                  height: 50,
                  child: Floatingsky(
                    typeName: widget.typeName,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
