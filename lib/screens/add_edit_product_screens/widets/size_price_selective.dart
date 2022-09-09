import 'package:flutter/material.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class SizePriceSelective extends StatelessWidget {
  const SizePriceSelective(
      {Key? key,
      required this.type,
      this.price = 0,
      required this.addPriceWithSize})
      : super(key: key);

  final Function(ProductSizeEnum, double price) addPriceWithSize;
  final ProductSizeEnum type;
  final double price;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    double _price = price;
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
                  controller: _controller,
                  textDirection: TextDirection.rtl,
                  decoration: const InputDecoration(
                      hintText: "السعر",
                      hintTextDirection: TextDirection.rtl))),
          IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _price = double.tryParse(_controller.text) ?? 0;
                  if (double.tryParse(_controller.text) != null) {
                    addPriceWithSize(type, price);
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
