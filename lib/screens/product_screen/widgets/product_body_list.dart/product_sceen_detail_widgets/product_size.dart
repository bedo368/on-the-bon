import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.sizePrice,
  }) : super(key: key);
  final Map<String, double> sizePrice;

  static final ValueNotifier<String> selectedSize =
      ValueNotifier<String>("كبير");
  @override
  Widget build(BuildContext context) {
    final sizesLiest = sizePrice.keys.toList();
    selectedSize.value = sizePrice.keys.first;
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
                        backgroundColor: v == sizesLiest[index]
                            ? Theme.of(context).colorScheme.secondary
                            : const Color.fromRGBO(235, 235, 235, 1),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        ProductSize.selectedSize.value = sizesLiest[index];
                      },
                      child: Text(sizesLiest[index],
                          style: TextStyle(
                              fontSize: 10,
                              color: v == sizesLiest[index]
                                  ? Colors.white
                                  : Colors.black)));
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
