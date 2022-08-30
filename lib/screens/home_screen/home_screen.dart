import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';
import 'package:on_the_bon/helper/auth.dart';

import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName  = "/"; 

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: globalKey,
      drawer: const Drawer(
        backgroundColor: Colors.amber,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          "On The Bon",
          style: TextStyle(fontFamily: "RockSalt"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProdcutsFiltter(),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProductCard(
                        imageUrl:
                            "https://i.im.ge/2022/08/28/ONgcn1.Pngtreeflying-cup-of-coffee-with-5057949.png"),
                    const ProductCard(
                      imageUrl:
                          "https://i.im.ge/2022/08/28/ONRxCP.Pngtreea-cup-of-black-coffee-4983144.png",
                      haveMultiSize: true,
                    ),
                    const ProductCard(
                        imageUrl:
                            "https://i.im.ge/2022/08/28/ONRPlD.pngwing-com.png"),
                    ElevatedButton(
                        onPressed: () {
                          Auth.signOut();
                        },
                        child: const Text("logout")),
                    ElevatedButton(
                        onPressed: () {
                          print(FirebaseAuth.instance.currentUser!);
                        },
                        child: const Text("logout")),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
