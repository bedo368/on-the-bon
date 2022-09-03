import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/product_screen/widgets/product_body_list.dart/product_sceen_detail_widgets/product_size.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key? key,
    required this.price,
  }) : super(key: key);
  final Map<String, double> price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "السعر ",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.end,
              ),
              const Text(
                " :",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.end,
              ),
              ValueListenableBuilder(
                  valueListenable: ProductSize.selectedSize,
                  builder: (context, v, c) {
                    return Text(
                      "${price[v] ?? price.values.first} LE",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                      textAlign: TextAlign.end,
                    );
                  })
            ]));
  }
}
