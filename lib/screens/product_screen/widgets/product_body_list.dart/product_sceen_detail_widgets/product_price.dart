import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "السعر ",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.end,
              ),
              Text(
                " :",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.end,
              ),
              Text(
                "20 LE",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.end,
              )
            ]));
  }
}