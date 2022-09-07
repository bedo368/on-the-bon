import 'package:flutter/material.dart';
import 'package:on_the_bon/models/product.dart';

class ProductManageCard extends StatelessWidget {
  const ProductManageCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Row(textDirection: TextDirection.rtl, children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * .25,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 90,
                    height: 25,
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 226, 224, 224)),
                        onPressed: () {},
                        child: const Text(
                          'تعديل',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    width: 60,
                    height: 25,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {},
                        child: const Text(
                          'حذف',
                          style: TextStyle(fontSize: 14),
                        )),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
