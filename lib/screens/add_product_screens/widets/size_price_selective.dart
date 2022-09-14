import 'package:flutter/material.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class SizePriceSelective extends StatelessWidget {
  const SizePriceSelective(
      {Key? key, required this.type, required this.addPriceWithSize})
      : super(key: key);

  final Function(ProductSizeEnum, double price) addPriceWithSize;
  final ProductSizeEnum type;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    double _price = 0;
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
                  onEditingComplete: () {
                    if (controller.text.isNotEmpty) {
                      _price = double.tryParse(controller.text) ?? 0;
                      if (double.tryParse(controller.text) != null) {
                        addPriceWithSize(type, _price);
                      }
                    }
                  },
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
