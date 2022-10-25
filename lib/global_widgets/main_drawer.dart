import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/data/helper/auth.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/send_notification_screen/send_notification_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    if (Provider.of<User>(context, listen: false).uid.isNotEmpty &&
        Provider.of<UserData>(context, listen: false).id !=
            Provider.of<User>(context, listen: false).uid) {
      Provider.of<UserData>(context, listen: false).fetchUserDataAsync();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            if (userData.isAdmin == true)
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductManageScreen.routeName);
                  },
                  title: Text(
                    "إداره المنتجات",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.end,
                  )),
            if (userData.isAdmin == true)
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(OrderManageScreen.routeName);
                  },
                  title: Text(
                    "إدارة الطلبات",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(OrdersScreen.routeName);
                },
                title: Text(
                  "طلباتي",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            if (userData.isAdmin == true)
              ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SendNotificationScreen.routeName);
                  },
                  title: Text(
                    "ارسال اشعار",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ListTile(
                onTap: () async {
                  Provider.of<Products>(context, listen: false).clearProducts();
                  await Auth.signOut(context);
                },
                title: Text(
                  "تسجيل الخروج",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
