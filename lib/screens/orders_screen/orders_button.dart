import 'package:flutter/material.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({
    Key? key,
  }) : super(key: key);
  static final ValueNotifier<OrderTypeEnum> activeOrders =
      ValueNotifier<OrderTypeEnum>(OrderTypeEnum.orderInProgress);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder(
              valueListenable: OrdersButton.activeOrders,
              builder: (context, v, c) {
                return GestureDetector(
                  onTap: () {
                    OrdersButton.activeOrders.value =
                        OrderTypeEnum.rejectedOrder;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: v == OrderTypeEnum.rejectedOrder
                                  ? BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)
                                  : const BorderSide(
                                      width: 0, color: Colors.white))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "الطلبات المرفوضه",
                        style: TextStyle(color: Colors.black),
                      )),
                );
              }),
          ValueListenableBuilder(
              valueListenable: OrdersButton.activeOrders,
              builder: (context, v, c) {
                return GestureDetector(
                  onTap: () {
                    OrdersButton.activeOrders.value =
                        OrderTypeEnum.successfulOrder;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: v == OrderTypeEnum.successfulOrder
                                  ? BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)
                                  : const BorderSide(
                                      width: 0, color: Colors.white))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "الطلبات السابقه",
                        style: TextStyle(color: Colors.black),
                      )),
                );
              }),
          ValueListenableBuilder(
              valueListenable: OrdersButton.activeOrders,
              builder: (context, v, c) {
                return GestureDetector(
                  onTap: () {
                    OrdersButton.activeOrders.value =
                        OrderTypeEnum.orderInProgress;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: v == OrderTypeEnum.orderInProgress
                                  ? BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)
                                  : const BorderSide(
                                      width: 0, color: Colors.white))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "الطلبات الحالية",
                        style: TextStyle(
                            color: v == OrderTypeEnum.orderInProgress
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.black),
                      )),
                );
              }),
        ],
      ),
    );
  }
}
