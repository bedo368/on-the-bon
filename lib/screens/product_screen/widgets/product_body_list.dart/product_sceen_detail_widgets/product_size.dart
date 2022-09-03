import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.sizePrice,
    required this.size,
  }) : super(key: key);
  final Map<String, double> sizePrice;
  final String size;

  static final ValueNotifier<String> selectedSize =
      ValueNotifier<String>("كبير");
  @override
  Widget build(BuildContext context) {

    final sizesLiest = sizePrice.keys.toList();
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 10),
              width: 80,
              height: 28,
              child: ValueListenableBuilder(
                valueListenable: ProductSize.selectedSize,
                builder: (context, v, e) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: v == sizesLiest[index]
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.grey,
                          padding: const EdgeInsets.all(0),
                          textStyle: const TextStyle(fontSize: 10)),
                      onPressed: () {
                        ProductSize.selectedSize.value = sizesLiest[index];
                      },
                      child: Text(sizesLiest[index]));
                },
              ),
            );
          },
          itemCount: sizePrice.length,
        ),
      ),
    );
  }
}
