import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/order_widget.dart';
import 'package:on_the_bon/screens/orders_screen/orders_button.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static String routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
  static ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void> fetchOrders() async {
    OrdersScreen.isLoading.value = true;

    try {
      await Provider.of<Orders>(context, listen: false)
          .getOrdersforUserByType(OrdersButton.activeOrders.value);
      OrdersScreen.isLoading.value = false;
    } catch (e) {
      OrdersScreen.isLoading.value = false;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrdersButton(
              fetchOrderFunction: fetchOrders,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              margin: const EdgeInsets.only(top: 40),
              child: ValueListenableBuilder<bool>(
                  valueListenable: OrdersScreen.isLoading,
                  builder: (context, value, c) {
                    return value
                        ? const Center(
                            child: SpinKitPouringHourGlassRefined(
                              color: Colors.green,
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return OrderWidget(
                                order: ordersData.orders[index],
                              );
                            },
                            itemCount: ordersData.orders.length,
                          );
                  }),
            )
          ],
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
