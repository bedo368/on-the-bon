import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class ProdcutsFiltterByType extends StatelessWidget {
  const ProdcutsFiltterByType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HomeScreen.productType,
        builder: (context, v, c) {
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
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
                            HomeScreen.productType.value =
                                ProductsType.hotDrinks;
                            Provider.of<Products>(context, listen: false)
                                .setType(ProductsType.hotDrinks);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: v == ProductsType.hotDrinks
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.grey,
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: const Center(
                              child: Text(
                                "مشروبات ساخنه",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HomeScreen.productType.value =
                                ProductsType.coldDrinks;
                            Provider.of<Products>(context, listen: false)
                                .setType(ProductsType.coldDrinks);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: v == ProductsType.coldDrinks
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.grey,
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: const Center(
                              child: Text(
                                "مشروبات بارده",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HomeScreen.productType.value = ProductsType.food;
                            Provider.of<Products>(context, listen: false)
                                .setType(ProductsType.food);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: v == ProductsType.food
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.grey,
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: const Center(
                              child: Text(
                                "مأكولات",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
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
        });
  }
}
