import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/screens/edit_product_screen/edit_product_screen.dart';
import 'package:on_the_bon/screens/add_product_screens/add_product_screen.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:on_the_bon/screens/favorite_screen/favorite_screen.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/onboarding_screen/onboarding_screen.dart';
import 'package:on_the_bon/screens/order_screen/order_screen.dart';
import 'package:on_the_bon/screens/orders_manage_screen/order_manage_screen.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:on_the_bon/screens/product_manage_screen/product_manage_screen.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';
import 'package:on_the_bon/screens/send_notification_screen/send_notification_screen.dart';
import 'package:on_the_bon/screens/sign_screen/sign_screen.dart';
import 'package:on_the_bon/service/manage_notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  NotificationApi.requestPermission();

  NotificationApi.setUpMainNotificationChannel();

  // FirebaseMessaging.onBackgroundMessage(
  //     NotificationApi.handeleBackgroundNotification);
  FirebaseMessaging.onMessage
      .listen(NotificationApi.handeleForgroundNotification);
  FirebaseMessaging.onMessageOpenedApp
      .listen(NotificationApi.onNotificationOpenAPP);

  await FirebaseAppCheck.instance.activate();
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool("hideonboardscreen") ?? false;

  runApp(MyApp(
    showOnboarding: showOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({Key? key, required this.showOnboarding}) : super(key: key);
  final bool showOnboarding;
  static bool firstOpen = true;

  @override
  Widget build(BuildContext context) {
    firstOpen = true;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(61, 26, 26, 1),
        statusBarBrightness: Brightness.dark));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        StreamProvider<auth.User?>.value(
          value: auth.FirebaseAuth.instance.authStateChanges(),
          initialData: auth.FirebaseAuth.instance.currentUser,
        ),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scrollBehavior: const CupertinoScrollBehavior(),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: const Locale('ar', 'AE'),
        title: 'ON THE BON',
        theme: ThemeData(
                primaryTextTheme:
                    TextTheme(button: TextStyle(color: Colors.white)),
                // useMaterial3: true,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    backgroundColor: Theme.of(context).primaryColor),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 22, color: Colors.white)),
                scaffoldBackgroundColor:
                    const Color.fromARGB(255, 255, 255, 255),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        textStyle: GoogleFonts.itim(
                            fontSize: 18, color: Colors.white))),
                primaryColor: const Color.fromRGBO(61, 26, 26, 1),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: const Color.fromRGBO(177, 35, 35, 1)))
            .copyWith(),
        home: StreamBuilder(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return showOnboarding ? const HomeScreen() : OnBoardingScreen();
            } else {
              if (auth.FirebaseAuth.instance.currentUser == null) {
                return showOnboarding
                    ? const LogInScreen()
                    : OnBoardingScreen();
              }
              if (Provider.of<auth.User>(context).uid.isNotEmpty) {
                if (auth.FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
                  Provider.of<UserData>(context, listen: false)
                      .fetchUserDataAsync();
                }
                return showOnboarding ? const HomeScreen() : OnBoardingScreen();
              }
              return showOnboarding ? OnBoardingScreen() : const LogInScreen();
            }
          },
        ),
        routes: {
          ProductScreen.routeName: (context) => const ProductScreen(),
          LogInScreen.routeName: (context) => const LogInScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          OrderManageScreen.routeName: (context) => const OrderManageScreen(),
          AddProductScreen.routeName: (context) => const AddProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
          ProductManageScreen.routeName: (context) =>
              const ProductManageScreen(),
          FaivoriteScreen.routeName: (context) => const FaivoriteScreen(),
          SendNotificationScreen.routeName: (context) =>
              const SendNotificationScreen(),
          OrderScreen.routeName: (context) => OrderScreen(orderId: "ff")
        },
      ),
    );
  }
}
