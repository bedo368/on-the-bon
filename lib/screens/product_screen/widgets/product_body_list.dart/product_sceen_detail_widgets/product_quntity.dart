import 'package:flutter/material.dart';

class ProductQuntity extends StatelessWidget {
  const ProductQuntity({
    Key? key,
  }) : super(key: key);

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
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 30,
            height: 44,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 242, 246, 1),
                borderRadius: BorderRadius.circular(3)),
            child: const Center(
                child: Text(
              "34",
              style: TextStyle(fontSize: 16),
            )),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              )),
        ],
      ),
    );
  }
}
