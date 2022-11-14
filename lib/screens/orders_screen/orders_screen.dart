import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/global_widgets/main_drawer.dart';
import 'package:on_the_bon/global_widgets/navigation_bar.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_item.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_button.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static String routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
  static ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = false;
  bool connectionStateDisabled = false;

  Future<void> fetchOrders() async {
    OrdersScreen.isLoading.value = true;

    try {
      final internetconnection =
          await InternetConnectionChecker.createInstance().hasConnection;
      if (!internetconnection) {
        setState(() {
          isLoading = false;
          connectionStateDisabled = true;
        });
        return;
      }
      setState(() {
        isLoading = true;
        connectionStateDisabled = false;
      });
      // ignore: empty_catches
    } catch (e) {}

    try {
      // ignore: use_build_context_synchronously
      await Provider.of<Orders>(context, listen: false)
          .getOrdersforUserByType(OrdersButton.activeOrders.value);
      OrdersScreen.isLoading.value = false;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      OrdersScreen.isLoading.value = false;
      setState(() {
        isLoading = false;
        connectionStateDisabled = true;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("حدث خطا ما حاول مره اخري ")));

      rethrow;
    }
  }

  @override
  void initState() {
    OrdersButton.activeOrders.value = OrderTypeEnum.orderInProgres;
    OrdersScreen.isLoading.value = true;
    fetchOrders().then((value) {
      OrdersScreen.isLoading.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ordersData = Provider.of<Orders>(context);
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          bottomNavigationBar: ButtomNavigationBar(
            routeName: OrdersScreen.routeName,
          ),
          drawer: const MainDrawer(),
          appBar: AppBar(
            title: const Text(
              "قائمه طلباتي",
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SizedBox(
            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
            child: Stack(
              children: [
                isLoading
                    ? const Center(
                        child: IconGif(
                        iconPath: "assets/images/search.gif",
                        content: "",
                        width: 100,
                      ))
                    : connectionStateDisabled == false
                        ? Positioned(
                            top: 55,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              height: mediaQuery.size.height,
                              // margin: const EdgeInsets.only(top: 40),
                              child: ordersData.orders.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              top: index == 0 ? 10 : 0,
                                              left: 10,
                                              right: 10),
                                          child: OrderItem(
                                            order: ordersData.orders[index],
                                          ),
                                        );
                                      },
                                      itemCount: ordersData.orders.length,
                                    )
                                  : const IconGif(
                                      iconPath: "assets/images/emptycart.gif",
                                      content: "عذرا ليس لديك طلبات حاليا",
                                      width: 150,
                                    ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: fetchOrders,
                            child: const SingleChildScrollView(
                                child: IconGif(
                              iconPath: "assets/images/connection-error.gif",
                              content:
                                  " خطأ في الاتصال بالانترنت من فضلك حاول مجددا ",
                              width: 150,
                            )),
                          ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: OrdersButton(
                    fetchOrderFunction: fetchOrders,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

ButtonStyle customBotton() {
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent);
}
