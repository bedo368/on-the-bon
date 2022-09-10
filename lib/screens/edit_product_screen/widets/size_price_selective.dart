import 'package:flutter/material.dart';
import 'package:on_the_bon/type_enum/enums.dart';

// ignore: must_be_immutable
class SizePriceSelective extends StatelessWidget {
   SizePriceSelective(
      {Key? key,
      required this.type,
      required this.addPriceWithSize,
      this.price = 0})
      : super(key: key);

  final Function(ProductSizeEnum, double price) addPriceWithSize;
  final ProductSizeEnum type;
  double price;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    // ignore: no_leading_underscores_for_local_identifiers
    double _price = price;
    if (_price != 0) {
      controller.text = _price.toString();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 90,
            height: 50,
            child: DropdownButton<ProductSizeEnum>(
              items: [
                DropdownMenuItem(
                    value: type, child: Text(productSizeStringtoEnum[type]!))
              ],
              onChanged: (s) {},
              value: type,
            ),
          ),
          SizedBox(
              width: 60,
              height: 50,
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                      hintText: "السعر",
                      hintTextDirection: TextDirection.rtl))),
          IconButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  _price = double.tryParse(controller.text) ?? 0;
                  if (double.tryParse(controller.text) != null) {
                    addPriceWithSize(type, _price);
                  }
                }
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              )),
        ],
      ),
    );
  }
}
