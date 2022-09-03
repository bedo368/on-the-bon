import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:on_the_bon/screens/products_type_screen/prodcuts_type_screen.dart';
import 'package:on_the_bon/screens/sign_screen/sign_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get initialData => null;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: FirebaseAuth.instance.currentUser,
        ),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                  textStyle: GoogleFonts.itim(fontSize: 18),
                )),
                primaryColor: const Color.fromRGBO(46, 18, 8, 1),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: const Color.fromRGBO(177, 35, 35, 1)))
            .copyWith(backgroundColor: const Color.fromRGBO(46, 18, 8, 1)),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LogInScreen();
          },
        ),
        routes: {
          ProductsTypeScreen.routeName: (context) => const ProductsTypeScreen(),
          ProductScreen.routeName: (context) => const ProductScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
        },
      ),
    );
  }
}
