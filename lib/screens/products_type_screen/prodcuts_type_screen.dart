import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_card.dart';

class ProductsTypeScreen extends StatelessWidget {
  const ProductsTypeScreen({Key? key}) : super(key: key);
  static String routeName = "/products-type";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container( margin: const EdgeInsets.only(top: 20) ,child: const Text("مأكولات" ,style: TextStyle(fontSize: 20), )), 
            Container(
              padding: const EdgeInsets.only(top: 0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    ProductCard(
                        imageUrl:
                            "https://i.im.ge/2022/08/28/ONgcn1.Pngtreeflying-cup-of-coffee-with-5057949.png"),
                    ProductCard(
                      imageUrl:
                          "https://i.im.ge/2022/08/28/ONRxCP.Pngtreea-cup-of-black-coffee-4983144.png",
                      haveMultiSize: true,
                    ),
                    ProductCard(
                        imageUrl:
                            "https://i.im.ge/2022/08/28/ONRPlD.pngwing-com.png"),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
