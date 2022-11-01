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
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<String> productType =
      ValueNotifier<String>("مشروبات ساخنة");

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isLoading = true;
  final productGridScrollNotifier = ValueNotifier<bool>(false);
  final productGridScrollValueNotifier = ValueNotifier<double>(0);

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        await Provider.of<Products>(context, listen: false)
            .fetchProductAsync()
            .then((value) {
          HomeScreen.productType.value =
              Provider.of<Products>(context, listen: false).getCurrentType;
          ProductsFillterBySubType.subType.value =
              Provider.of<Products>(context, listen: false).currentSubType;
        });

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
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            extendBody: true,
            bottomNavigationBar: ButtomNavigationBar(
              routeName: HomeScreen.routeName,
            ),
            drawer: const MainDrawer(),
            body: Stack(
              children: [
                isLoading
                    ? const Center(
                        child: IconGif(
                        width: 90,
                        content: "",
                        iconPath: "assets/images/search.gif",
                      ))
                    : allProduct.isNotEmpty
                        ? Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: RefreshIndicator(
                              onRefresh: onRefreash,
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: mediaQuery.size.height),
                                child: Stack(
                                  children: [
                                    ValueListenableBuilder<bool>(
                                        valueListenable:
                                            productGridScrollNotifier,
                                        builder: (context, v, c) {
                                          return Positioned(
                                            top: 30,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              
                                              child: AnimatedOpacity(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                opacity: v ? 0 : 1,
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  width: size.width,
                                                  height: v ? 0 : 130,
                                                  child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .9,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3,
                                                            child:
                                                                const RiveAnimation
                                                                    .asset(
                                                              "assets/animation/logo_animation.riv",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),

                                    // ProductTypeNotifier(),
                                    ValueListenableBuilder<double>(
                                        valueListenable:
                                            productGridScrollValueNotifier,
                                        builder: (context, v, c) {
                                          return Positioned(
                                              top: 150 - v,
                                              child:
                                                  const ProdcutsFiltterByType());
                                        }),
                                    ValueListenableBuilder<double>(
                                        valueListenable:
                                            productGridScrollValueNotifier,
                                        builder: (context, v, c) {
                                          return Positioned(
                                            top: 240 - v,
                                            child:
                                                const ProductsFillterBySubType(),
                                          );
                                        }),
                                    ValueListenableBuilder<double>(
                                        valueListenable:
                                            productGridScrollValueNotifier,
                                        builder: (context, v, c) {
                                          return Positioned(
                                              top: 310 - v,
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child:
                                                  ProductGraid(onScroll: (p) {
                                                productGridScrollNotifier
                                                    .value = p > 20;
                                                if (p < 160) {
                                                  productGridScrollValueNotifier
                                                      .value = p;
                                                }
                                              }));
                                        }),
                                    Positioned(
                                        right: 10,
                                        top: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.menu,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            _scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                        )),
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
                // Positioned(
                //     right: 10,
                //     top: 0,
                //     child: IconButton(
                //       icon: const Icon(
                //         Icons.menu,
                //         size: 40,
                //       ),
                //       onPressed: () {
                //         _scaffoldKey.currentState!.openDrawer();
                //       },
                //     )),
              ],
            )),
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
