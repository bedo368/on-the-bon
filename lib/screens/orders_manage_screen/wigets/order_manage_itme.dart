import 'package:flutter/material.dart';

import 'package:on_the_bon/models/order.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class OrderManageItem extends StatelessWidget {
  const OrderManageItem({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            order.ordersItems[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " / ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            order.ordersItems[index].size,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            order.ordersItems[index].price.toInt().toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " * ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            order.ordersItems[index].quantity
                                .toInt()
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " = ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${order.ordersItems[index].quantity.toInt() * order.ordersItems[index].price.toInt()}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            "جنيه ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: order.ordersItems.length,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: const Center(
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "العنوان  : ${order.location}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الهاتف  : ${order.phoneNumber}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "الاجمالي :    ${order.totalPrice} جنيها   +   خدمة التوصيل",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        print("طلب ناجح");
                        await Provider.of<Orders>(context, listen: false)
                            .cahngeOrderType(
                                newtype: OrderTypeEnum.successfulOrder,
                                orderId: order.id,
                                oldType: order.orderType);

                        print("طلب ناجح");
                      },
                      child: const Text(
                        "طلب ناجح",
                        style: TextStyle(color: Colors.amber),
                      )),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<Orders>(context, listen: false)
                          .cahngeOrderType(
                              newtype: OrderTypeEnum.rejectedOrder,
                              orderId: order.id,
                              oldType: order.orderType);
                    },
                    child: const Text(
                      "طلب مرفوض",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
