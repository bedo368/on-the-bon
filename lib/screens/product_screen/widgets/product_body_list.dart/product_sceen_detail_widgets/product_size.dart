import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
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
            "الحجم",
            style: TextStyle(color: Colors.white, fontSize: 22),
            textAlign: TextAlign.end,
          ),
          Container(
            margin: const EdgeInsets.only(right: 30, left: 15),
            width: 60,
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(249, 242, 246, 1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4)),
              child: const Text(
                "large",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 4)),
              child: const Text(
                "meduim",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}