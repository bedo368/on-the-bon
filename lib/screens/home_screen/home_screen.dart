import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/global_widgets/confirm_dialog.dart';
import 'package:on_the_bon/global_widgets/product_search_delgate.dart';
import 'package:on_the_bon/helper/auth.dart';
import 'package:on_the_bon/helper/subscribe_to_admin.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_subtype.dart';

import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_type.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_graid.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<ProductsTypeEnum> productType =
      ValueNotifier<ProductsTypeEnum>(ProductsTypeEnum.hotDrinks);

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

      subscreibToAdmin();

      Provider.of<Products>(context, listen: false)
          .setType(HomeScreen.productType.value);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.of(context).pushNamed(CartScreen.routeName);
    });

    FirebaseMessaging.onMessage.listen((event) async {
      showConfirmDialog(
          content: event.notification!.body ?? "",
          title: event.notification!.title ?? "",
          confirmText: "ذهاب للصفحه",
          cancelText: "اخفاء",
          context: context,
          onConfirm: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          },
          onCancel: () {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();
    final allProduct = Provider.of<Products>(context).allProducts;

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
              ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrdersScreen.routeName);
                  },
                  leading: const Text("my orders")),
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrderManageScreen.routeName);
                  },
                  leading: const Text("manage orders")),
              ListTile(
                  onTap: () async {
                    await Auth.signOut();
                  },
                  leading: const Text("log out")),
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
          ? Center(
              child: SpinKitChasingDots(
                color: Theme.of(context).primaryColor,
              ),
            )
          : allProduct.isNotEmpty
              ? SingleChildScrollView(
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
                )
              : const Center( child: Text("خطأ في الاتصال بالانترنت من فضلك حاول مجددا")),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Consumer<Products>(builder: (context, v, c) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => SlideTransition(
              position: animation.drive(Tween<Offset>(
                  begin: const Offset(0, -1), end: const Offset(0, 0))),
              child: child),
          child: Text(
            key: ValueKey(v.getCurrentType),
            "  ${v.getCurrentType}  ",
            style: const TextStyle(fontSize: 23, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
