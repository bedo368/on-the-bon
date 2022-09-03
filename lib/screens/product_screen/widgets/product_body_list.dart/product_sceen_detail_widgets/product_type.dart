import 'package:flutter/material.dart';

class ProductType extends StatelessWidget {
  const ProductType({
    Key? key,
    required this.type,
    required this.subType,
  }) : super(key: key);
  final String type;
  final String subType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(249, 242, 246, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        "النوع : $type/ $subType",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
