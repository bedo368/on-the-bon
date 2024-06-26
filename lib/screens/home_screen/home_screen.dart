import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_the_bon/data/helper/subscribe_to_topic.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/global_widgets/clip_shadow.dart';
import 'package:on_the_bon/global_widgets/main_drawer.dart';
import 'package:on_the_bon/global_widgets/navigation_bar.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/global_widgets/stroked_text.dart';
import 'package:on_the_bon/main.dart';
import 'package:on_the_bon/screens/home_screen/widgets/custom_clip_path.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_subtype.dart';
import 'package:on_the_bon/screens/home_screen/widgets/products_filter/product_filtter_by_type.dart';
import 'package:on_the_bon/screens/home_screen/widgets/product_graid.dart';
import 'package:on_the_bon/screens/sign_screen/sign_screen.dart';
import 'package:on_the_bon/service/manage_notification.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/";
  static final ValueNotifier<String> productType =
      ValueNotifier<String>(productsStringToType.keys.first);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isLoading = true;
  final productGridScrollNotifier = ValueNotifier<bool>(false);
  final productGridScrollValueNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    }
    NotificationApi.requestPermission();

    setState(() {
      isLoading = true;
    });

    if (MyApp.firstOpen) {
      SubscribeToNotificationTopic.subscreibToAdmin();
      SubscribeToNotificationTopic.subscreibToUsers();
    }

    if (FirebaseAuth.instance.currentUser != null) {
      Provider.of<UserData>(context, listen: false).fetchUserDataAsync();
    }

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

  double scrollvalue = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          bottomNavigationBar: ButtomNavigationBar(
            routeName: HomeScreen.routeName,
          ),
          drawer: const MainDrawer(),
          body: Stack(
            children: [
              ValueListenableBuilder<double>(
                  valueListenable: productGridScrollValueNotifier,
                  builder: (context, v, c) {
                    return Positioned(
                      top: 0,
                      child: Container(
                        child: ClipShadowPath(
                          shadow: BoxShadow(
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                              offset: const Offset(0, 5),
                              spreadRadius: 5,
                              color: Theme.of(context).primaryColor),
                          clipper: WaveClip(
                              lowPointPosition: 15, hightPointPosition: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 155 - v / 1,
                            color: Theme.of(context).primaryColor,
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                      left: 0,
                                      child: Image.asset(
                                        "assets/animation/coffee-gif.gif",
                                        fit: BoxFit.cover,
                                        width: 90 - scrollvalue / 5,
                                      )),
                                  Positioned(
                                    top: -10,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      opacity: scrollvalue > 10 ? 0 : 1,
                                      child: StrockedText(
                                        "%",
                                        fontFamily: "permanentMarker",
                                        strokeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 60 - v / 3,
                                        shadow: const [],
                                        strokeWidth: 4,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 45 - v / 4.3 - scrollvalue / 4.5,
                                    child: StrockedText(
                                      "On The Bon",
                                      fontFamily: "RockSalt",
                                      strokeColor: Theme.of(context).colorScheme.secondary,
                                      fontSize: 30 - v / 5 + scrollvalue / 10,
                                      shadow: const [],
                                      strokeWidth: 2,
                                      color: Colors.white,
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
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight: mediaQuery.size.height),
                            child: Stack(
                              children: [
                                // ProductTypeNotifier(),
                                ValueListenableBuilder<double>(
                                    valueListenable:
                                        productGridScrollValueNotifier,
                                    builder: (context, v, c) {
                                      return Positioned(
                                          top: 134 - v,
                                          child: const ProdcutsFiltterByType());
                                    }),
                                ValueListenableBuilder<double>(
                                    valueListenable:
                                        productGridScrollValueNotifier,
                                    builder: (context, v, c) {
                                      return Positioned(
                                        top: 215 - v,
                                        child: const ProductsFillterBySubType(),
                                      );
                                    }),
                                ValueListenableBuilder<double>(
                                    valueListenable:
                                        productGridScrollValueNotifier,
                                    builder: (context, v, c) {
                                      return Positioned(
                                          top: 270 - v,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: ProductGraid(onScroll: (p) {
                                            scrollvalue = p;
                                            if (p < 80 && p > 0) {
                                              if (p > 60 && p < scrollvalue) {
                                                scrollvalue += 1;
                                              }
                                              if (p > 60 && p > scrollvalue) {
                                                scrollvalue -= 1;
                                              }
                                              productGridScrollValueNotifier
                                                  .value = p;
                                            }
                                            if (p > 80) {
                                              productGridScrollValueNotifier
                                                  .value = 80;
                                            }
                                            if (p <= 0) {
                                              productGridScrollValueNotifier
                                                  .value = 0;
                                            }
                                          }));
                                    }),
                              ],
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
              Positioned(
                  right: 10,
                  top: 5,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 44,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  )),
            ],
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
