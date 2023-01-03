import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_bon/data/helper/auth.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/favorite_screen/favorite_screen.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/send_notification_screen/send_notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (Provider.of<UserData>(context, listen: false).id !=
          FirebaseAuth.instance.currentUser!.uid) {
        Provider.of<UserData>(context, listen: false).fetchUserDataAsync();
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Drawer(
      width: 300,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Positioned(
              top: 0,
              left: -18,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      left: -84,
                      child: Transform.rotate(
                        angle: pi / 1.3,
                        child: Container(
                          width: 320,
                          height: 150,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          width: 90,
                          height: 90,
                          child: Image.network(
                            Provider.of<UserData>(context, listen: false)
                                .photoUrl as String,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 150,
                        right: 30,
                        child: Text(
                          Provider.of<UserData>(context, listen: false)
                              .displayName as String,
                          style: TextStyle(color: Colors.white),
                        )),
                    // Positioned(
                    //   top: 50,
                    //   left: 30,
                    //   child: Container(
                    //       width: 90,
                    //       child: Image.asset(
                    //         "assets/animation/coffee-gif.gif",
                    //         fit: BoxFit.cover,
                    //       )),
                    // ),
                  ],
                ),
              )),
          Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerElement(
                      title: "الصفخه الرئيسيىة",
                      icon: Icons.home,
                      onTap: () {
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      },
                    ),
                    DrawerElement(
                      title: "المفضلة",
                      icon: Icons.list_alt_rounded,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FaivoriteScreen.routeName);
                      },
                    ),
                    DrawerElement(
                      title: "طلباتي",
                      icon: Icons.favorite,
                      onTap: () {
                        Navigator.of(context).pushNamed(OrdersScreen.routeName);
                      },
                    ),
                    DrawerElement(
                      title: "العربة",
                      icon: Icons.shopping_bag,
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                    ),
                    DrawerElement(
                      title: "فيس بوك",
                      icon: Icons.facebook,
                      onTap: () async {
                        try {
                          var whatsappUrl = "https://www.facebook.com/KAHWAGIA";
                          if (await launchUrl(Uri.parse(whatsappUrl),
                              mode: LaunchMode.externalNonBrowserApplication)) {
                          } else {
                            await launchUrl(
                                Uri.parse("https://www.facebook.com/KAHWAGIA"));
                          }
                        } catch (e) {
                          await launchUrl(
                              Uri.parse("https://www.facebook.com/KAHWAGIA"));
                        }
                      },
                    ),
                    DrawerElement(
                      title: "انستجرام",
                      icon: Ionicons.logo_instagram,
                      onTap: () async {
                        try {
                          var whatsappUrl =
                              "instagram://user?username=on_the_bon";
                          await launchUrl(Uri.parse(whatsappUrl));

                          if (await launchUrl(Uri.parse(whatsappUrl))) {
                          } else {
                            await launchUrl(Uri.parse(
                                "https://instagram.com/on_the_bon?igshid=YmMyMTA2M2Y="));
                          }
                        } catch (e) {
                          await launchUrl(Uri.parse(
                              "https://instagram.com/on_the_bon?igshid=YmMyMTA2M2Y="));
                        }
                      },
                    ),
                    DrawerElement(
                      title: "تواصل معنا",
                      icon: Icons.call,
                      onTap: () async {
                        var whatsappUrl = "tel://0472517754";
                        await launchUrl(Uri.parse(whatsappUrl));
                      },
                    ),
                    DrawerElement(
                      title: "التطبيق",
                      icon: Ionicons.logo_google_playstore,
                      onTap: () {},
                    ),
                    if (userData.isAdmin as bool)
                      DrawerElement(
                        title: "ادارة المنتجات",
                        icon: Icons.manage_accounts,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProductManageScreen.routeName);
                        },
                      ),
                    if (userData.isAdmin as bool)
                      DrawerElement(
                        title: "ادارة الطلبات",
                        icon: Icons.manage_history,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OrderManageScreen.routeName);
                        },
                      ),
                    if (userData.isAdmin as bool)
                      DrawerElement(
                        title: "ارسال اشعار",
                        icon: Icons.notification_add,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SendNotificationScreen.routeName);
                        },
                      ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: DrawerElement(
                        title: "تسجيل الخروج",
                        icon: Icons.logout,
                        onTap: () async {
                          Provider.of<Products>(context, listen: false)
                              .clearProducts();
                          await Auth.signOut().then((value) {
                            Provider.of<UserData>(context, listen: false)
                                .clearData();
                          });
                          try {} catch (e) {
                            rethrow;
                          }
                        },
                      ),
                    ),

                    // Column(
                    //   children: [
                    //     Container(
                    //       height: 35,
                    //       child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               "للتواصل مع المطور اضغط ",
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //             GestureDetector(
                    //                 onTap: () async {
                    //                   var whatsappUrl =
                    //                       "whatsapp://send?phone=+201020766083";
                    //                   await launchUrl(Uri.parse(whatsappUrl));
                    //                 },
                    //                 child: Text(
                    //                   "هنا",
                    //                   style: TextStyle(
                    //                       color: Colors.blue,
                    //                       fontWeight: FontWeight.bold),
                    //                 ))
                    //           ]),
                    //     ),
                    //     Container(
                    //       height: 35,
                    //       margin: EdgeInsets.all(0),
                    //       padding: EdgeInsets.all(0),
                    //       child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               "للتواصل مع الجرافيك اضغط  ",
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //             GestureDetector(
                    //                 onTap: () async {
                    //                   var whatsappUrl =
                    //                       "whatsapp://send?phone=+";
                    //                   await launchUrl(Uri.parse(whatsappUrl));
                    //                 },
                    //                 child: Text(
                    //                   "هنا",
                    //                   style: TextStyle(
                    //                       color: Colors.blue,
                    //                       fontWeight: FontWeight.bold),
                    //                 ))
                    //           ]),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}

class DrawerElement extends StatefulWidget {
  const DrawerElement({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  State<DrawerElement> createState() => _DrawerElementState();
}

class _DrawerElementState extends State<DrawerElement> {
  double opac = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (l) {
        setState(() {
          opac = .1;
        });
      },
      onLongPressEnd: (l) {
        setState(() {
          opac = 0;
        });
      },
      onTap: () {
        widget.onTap();
        setState(() {
          opac = .1;
        });
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          setState(() {
            opac = 0;
          });
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(top: 10),
        duration: Duration(milliseconds: 50),
        color: opac == 0
            ? Colors.white.withOpacity(.2)
            : Colors.white.withOpacity(.1),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 25,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//  margin: const EdgeInsets.only(top: 40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 30),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: 100,
//                     height: 100,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(200),
//                         child: Image.network(
//                           FirebaseAuth.instance.currentUser!.photoURL!,
//                           fit: BoxFit.cover,
//                         )),
//                   ),
//                   Container(
//                       margin: const EdgeInsets.only(top: 5, bottom: 5),
//                       child: Text(
//                         FirebaseAuth.instance.currentUser!.displayName!,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       )),
//                   const Divider(
//                     height: 2,
//                     thickness: 2,
//                     color: Colors.black,
//                   )
//                 ],
//               ),
//             ),
//             if (userData.isAdmin == true)
//               ListTile(
//                   onTap: () {
//                     Navigator.of(context)
//                         .(ProductManageScreen.routeName);
//                   },
//                   title: Text(
//                     "إداره المنتجات",
//                     style: TextStyle(color: Theme.of(context).primaryColor),
//                     textAlign: TextAlign.end,
//                   )),
//             if (userData.isAdmin == true)
//               ListTile(
//                   onTap: () {
//                     Navigator.of(context)
//                         .(OrderManageScreen.routeName);
//                   },
//                   title: Text(
//                     "إدارة الطلبات",
//                     textAlign: TextAlign.end,
//                     style: TextStyle(color: Theme.of(context).primaryColor),
//                   )),
//             ListTile(
//                 onTap: () {
//                   Navigator.of(context).(OrdersScreen.routeName);
//                 },
//                 title: Text(
//                   "طلباتي",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(color: Theme.of(context).primaryColor),
//                 )),
//             if (userData.isAdmin == true)
//               ListTile(
//                   onTap: () {
//                     Navigator.of(context)
//                         .(SendNotificationScreen.routeName);
//                   },
//                   title: Text(
//                     "ارسال اشعار",
//                     textAlign: TextAlign.end,
//                     style: TextStyle(color: Theme.of(context).primaryColor),
//                   )),
//             ListTile(
//                 onTap: () {
//                   Provider.of<Products>(context, listen: false).clearProducts();
//                   Auth.signOut().then((value) {
//                     Provider.of<UserData>(context, listen: false).clearData();
//                   });
//                 },
//                 title: Text(
//                   "تسجيل الخروج",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(color: Theme.of(context).primaryColor),
//                 )),
//           ],
//         ),
