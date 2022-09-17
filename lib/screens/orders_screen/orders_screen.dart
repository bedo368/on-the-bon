import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_item.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_button.dart';
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
    OrdersScreen.isLoading.value = true;
    fetchOrders().then((value) {
      OrdersScreen.isLoading.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "قائمه طلباتي",
            textAlign: TextAlign.end,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: isLoading
          ? Center(
              child: SpinKitChasingDots(
                color: Theme.of(context).primaryColor,
              ),
            )
          : connectionStateDisabled == false
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      OrdersButton(
                        fetchOrderFunction: fetchOrders,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        margin: const EdgeInsets.only(top: 40),
                        child: ordersData.orders.isNotEmpty
                            ? ListView.builder(
                                reverse: true,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OrderItem(
                                    order: ordersData.orders[index],
                                  );
                                },
                                itemCount: ordersData.orders.length,
                              )
                            : SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Center(
                                          child: Image.asset(
                                              "assets/images/emptycart.gif",
                                              width: 150,
                                              fit: BoxFit.cover)),
                                    ),
                                    const Center(
                                      child: Text(
                                        "عذا ليس لديك طلبات حاليا",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchOrders,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        margin: const EdgeInsets.only(top: 200),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/search.gif",
                              fit: BoxFit.cover,
                              width: 150,
                            ),
                            const Center(
                                child: Text(
                                    " خطأ في الاتصال بالانترنت من فضلك حاول مجددا ")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
