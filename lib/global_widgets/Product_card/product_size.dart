import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  const ProductSize({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 60,
            height: 28,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.all(0),
                    textStyle: const TextStyle(fontSize: 10)),
                onPressed: () {},
                child: const Text("Meduim")),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 60,
            
            height: 28,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: const EdgeInsets.all(0),
                    textStyle: const TextStyle(fontSize: 10)),
                onPressed: () {},
                child: const Text("Large")),
          ),
        ],
      ),
    );
  }
}
