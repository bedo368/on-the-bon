import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/product_search_delgate.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_subtype.dart';

import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_type.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_graid.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<ProductsTypeEnum> productType =
      ValueNotifier<ProductsTypeEnum>(ProductsTypeEnum.food);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .fetchProductAsync()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    final type = Provider.of<Products>(context, listen: false).getCurrentType;
    if (type == "مأكولات") {
      HomeScreen.productType.value = ProductsTypeEnum.food;
    } else if (type == "مشروبات ساخنة") {
      HomeScreen.productType.value = ProductsTypeEnum.hotDrinks;
    } else if (type == "مشروبات باردة") {
      HomeScreen.productType.value = ProductsTypeEnum.coldDrinks;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      drawer: Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductManageScreen.routeName);
                  },
                  leading: const Text("Mange Product")),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "On The Bon",
          style: TextStyle(fontFamily: "RockSalt"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                        Provider.of<Products>(context, listen: false)
                            .allProducts, (context, id, type) {
                      Navigator.of(context).pushReplacementNamed(
                          ProductScreen.routeName,
                          arguments: {"id": id, "type": type});
                    }));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const ProdcutsFiltterByType(),
                  const ProductsFillterBySubType(),
                  const ProductTypeNotifier(),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const ProductGraid())
                ],
              ),
            ),
    );
  }
}

class ProductTypeNotifier extends StatelessWidget {
  const ProductTypeNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Consumer<Products>(builder: (context, v, c) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              SlideTransition(
                  position: animation.drive(Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: const Offset(0, 0))),
                  child: child),
          child: Text(
            key: ValueKey(v.getCurrentType),
            "  ${v.getCurrentType}  ",
            style: const TextStyle(
                fontSize: 23, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
