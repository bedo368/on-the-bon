import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/global_widgets/main_drawer.dart';
import 'package:on_the_bon/global_widgets/navigation_bar.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/main.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_subtype.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_type.dart';
import 'package:on_the_bon/screens/home_screen/widgets/product_graid.dart';
import 'package:on_the_bon/service/manage_notification.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<ProductsTypeEnum> productType =
      ValueNotifier<ProductsTypeEnum>(ProductsTypeEnum.hotDrinks);

  static final ValueNotifier<bool> isProductHomeScreenGridScroll =
      ValueNotifier<bool>(false);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isLoading = true;

  @override
  void initState() {
    NotificationApi.requestPermission();

    setState(() {
      isLoading = true;
    });

    InternetConnectionChecker.createInstance()
        .hasConnection
        .then((internetconnection) {
      if (!internetconnection) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    });

    if (Provider.of<UserData>(context, listen: false).id == null) {
      Provider.of<UserData>(context, listen: false).fetchUserDataAsync();
    }

    if (Provider.of<Products>(context, listen: false).allProducts.isEmpty ||
        MyApp.firstOpen) {
      Provider.of<Products>(context, listen: false)
          .fetchProductAsync()
          .then((value) {
        setState(() {
          isLoading = false;
        });

        Provider.of<Products>(context, listen: false)
            .setType(HomeScreen.productType.value);
        MyApp.firstOpen = false;
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("حدث خطا ما حاول مره اخري ")));
        setState(() {
          isLoading = false;
        });
      });
    }
    if (Provider.of<Products>(context, listen: false).allProducts.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final allProduct = Provider.of<Products>(
      context,
    ).allProducts;

    Future<void> onRefreash() async {
      try {
        final internetconnection =
            await InternetConnectionChecker.createInstance().hasConnection;
        if (!internetconnection) {
          setState(() {
            isLoading = false;
          });
          return;
        }
        // ignore: empty_catches
      } catch (e) {}

      try {
        setState(() {
          isLoading = true;
        });
        // ignore: use_build_context_synchronously
        await Provider.of<Products>(context, listen: false).fetchProductAsync();

        setState(() {
          isLoading = false;
        });

        // ignore: use_build_context_synchronously
        Provider.of<Products>(context, listen: false)
            .setType(HomeScreen.productType.value);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        rethrow;
      }
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
          child: Scaffold(
        extendBody: true,
        bottomNavigationBar: ButtomNavigationBar(
          routeName: HomeScreen.routeName,
        ),
        drawer: const MainDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: SizedBox(
            width: mediaQuery.size.width,
            child: const Text(
              "On The Bon",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "RockSalt"),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: IconGif(
                width: 90,
                content: "",
                iconPath: "assets/images/search.gif",
              ))
            : allProduct.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: onRefreash,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: mediaQuery.size.height,
                        child: Column(
                          children: [
                            ValueListenableBuilder<bool>(
                                valueListenable:
                                    HomeScreen.isProductHomeScreenGridScroll,
                                builder: (context, v, c) {
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: v ? 0 : 1,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: size.width,
                                      height: v ? 0 : 280,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                child:
                                                    const RiveAnimation.asset(
                                                  "assets/animation/logo_animation.riv",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const ProdcutsFiltterByType(),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child:
                                                    const ProductsFillterBySubType()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                            // ProductTypeNotifier(),
                            const Flexible(child: ProductGraid()),
                          ],
                        ),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: onRefreash,
                    child: const SingleChildScrollView(
                      child: IconGif(
                        width: 150,
                        content:
                            " خطأ في الاتصال بالانترنت من فضلك حاول مجددا ",
                        iconPath: "assets/images/connection-error.gif",
                      ),
                    ),
                  ),
      )),
    );
  }
}

class ProductTypeNotifier extends StatelessWidget {
  const ProductTypeNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: mediaQuery.size.width,
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
