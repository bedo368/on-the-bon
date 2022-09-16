import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/edit_product_screen/edit_product_screen.dart';
import 'package:on_the_bon/screens/add_product_screens/add_product_screen.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:on_the_bon/screens/sign_screen/sign_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<auth.User?>.value(
          value: auth.FirebaseAuth.instance.authStateChanges(),
          initialData: auth.FirebaseAuth.instance.currentUser,
        ),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 22, color: Colors.white)),
                scaffoldBackgroundColor:
                    const Color.fromARGB(255, 255, 255, 255),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        textStyle: GoogleFonts.itim(fontSize: 18))),
                primaryColor: const Color.fromARGB(255, 61, 26, 26),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: const Color.fromRGBO(177, 35, 35, 1)))
            .copyWith(backgroundColor: const Color.fromRGBO(5, 14, 14, 1)),
        home: StreamBuilder(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LogInScreen();
          },
        ),
        routes: {
          ProductScreen.routeName: (context) => const ProductScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          OrderManageScreen.routeName: (context) => const OrderManageScreen(),
          AddProductScreen.routeName: (context) => const AddProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
          ProductManageScreen.routeName: (context) =>
              const ProductManageScreen(),
        },
      ),
    );
  }
}
