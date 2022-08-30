import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/products_type_screen/prodcuts_type_screen.dart';

class ProdcutsFiltter extends StatelessWidget {
  const ProdcutsFiltter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              ": الأنواع",
              style: TextStyle(fontSize: 23),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(102, 248, 235, 202),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProductsTypeScreen.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: const Center(
                        child: Text(
                          "مشروبات ساخنه",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: const Center(
                      child: Text(
                        "مشروبات بارده",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey,
                    ),
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: const Center(
                      child: Text(
                        "مأكولات",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
