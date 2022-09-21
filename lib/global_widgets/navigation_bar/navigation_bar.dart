import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/product_search_delgate.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/favorite_screen/favorite_screen.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({super.key, required this.routeName});
  final String routeName;
  static int index = 0;

  @override
  Widget build(BuildContext context) {
    if (routeName == HomeScreen.routeName) {
      index = 2;
    } else if (routeName == CartScreen.routeName) {
      index = 1;
    } else if (routeName == OrdersScreen.routeName) {
      index = 0;
    } else if (routeName == FaivoriteScreen.routeName) {
      index = 3;
    }

    return SafeArea(
      child: CurvedNavigationBar(
        items: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.download,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  "طلباتي",
                  style: TextStyle(fontSize: 9, color: Colors.white),
                )
              ],
            ),
          ),
          Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_bag,
                  size: 33,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 13),
                child: Center(
                  child: Consumer<Cart>(builder: (context, value, child) {
                    return Text(
                      value.itemsCount.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              )
            ],
          ),
          const Icon(
            Icons.home,
            size: 33,
            color: Colors.white,
          ),
          const Icon(
            Icons.favorite,
            size: 33,
            color: Colors.white,
          ),
          const Icon(
            Icons.search,
            size: 33,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromARGB(255, 167, 50, 15),
        height: 55,
        index: ButtomNavigationBar.index,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          if (index == 2) {
            ButtomNavigationBar.index = index;
            if (routeName != HomeScreen.routeName) {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          } else if (index == 1) {
            ButtomNavigationBar.index = index;
            if (routeName != CartScreen.routeName) {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            }
          } else if (index == 0) {
            ButtomNavigationBar.index = index;
            if (routeName != OrdersScreen.routeName) {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            }
          } else if (index == 4) {
            showSearch(
                context: context,
                delegate: MySearchDelegate(
                    Provider.of<Products>(context, listen: false).allProducts,
                    (context, id, type) {
                  Navigator.of(context).pushReplacementNamed(
                      ProductScreen.routeName,
                      arguments: {"id": id, "type": type});
                }));
          } else if (index == 3) {
            if (routeName != FaivoriteScreen.routeName) {
              Navigator.of(context)
                  .pushReplacementNamed(FaivoriteScreen.routeName);
            }
          }
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
