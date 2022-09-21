import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_manage_screen/wigets/order_manage_itme.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_button.dart';
import 'package:provider/provider.dart';

class OrderManageScreen extends StatefulWidget {
  const OrderManageScreen({Key? key}) : super(key: key);
  static String routeName = "/orders-manage";

  @override
  State<OrderManageScreen> createState() => _OrderManageScreenState();
  static ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
}

class _OrderManageScreenState extends State<OrderManageScreen> {
  Future<void> fetchOrders() async {
    OrderManageScreen.isLoading.value = true;

    try {
      await Provider.of<Orders>(context, listen: false)
          .getOrdersForAdminsByType(OrdersButton.activeOrders.value);
      OrderManageScreen.isLoading.value = false;
    } catch (e) {
      OrderManageScreen.isLoading.value = false;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("حدث خطا ما حاول مره اخري ")));
      rethrow;
    }
  }

  @override
  void initState() {
    OrderManageScreen.isLoading.value = true;
    fetchOrders().then((value) {
      OrderManageScreen.isLoading.value = false;
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
                  valueListenable: OrderManageScreen.isLoading,
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
                              return OrderManageItem(
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
