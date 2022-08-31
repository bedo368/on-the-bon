import 'package:flutter/material.dart';

class ProductType extends StatelessWidget {
  const ProductType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(249, 242, 246, 1),
          borderRadius: BorderRadius.circular(10)),
      child: const Text(
        "النوع : اسبريسو",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
