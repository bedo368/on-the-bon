import 'package:flutter/material.dart';

class ProductQuntity extends StatelessWidget {
  const ProductQuntity({
    Key? key,
  }) : super(key: key);
  static final ValueNotifier<double> quetity = ValueNotifier<double>(1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "الكمية ",
            style: TextStyle(color: Colors.white, fontSize: 22),
            textAlign: TextAlign.end,
          ),
          IconButton(
              hoverColor: Colors.amber,
              onPressed: () {
                ProductQuntity.quetity.value += 1;
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 40,
            height: 35,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 242, 246, 1),
                borderRadius: BorderRadius.circular(3)),
            child: ValueListenableBuilder(
                valueListenable: ProductQuntity.quetity,
                builder: (context, v, e) {
                  return Center(
                      child: Text(
                    "${quetity.value.toInt()}",
                    style: const TextStyle(fontSize: 16),
                  ));
                }),
          ),
          IconButton(
              onPressed: () {
                if (ProductQuntity.quetity.value > 1) {
                  ProductQuntity.quetity.value -= 1;
                }
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 30,
              )),
        ],
      ),
    );
  }
}
