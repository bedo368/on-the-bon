import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/global_widgets/dvider_with_text.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final Order order;
  
  get timeDetailcreate => intl.DateFormat("a").format(order.createdAt);
  
  get timeDetailForconfirm => intl.DateFormat("a").format(order.deliverdAt!);

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
              Container(
                  margin: const EdgeInsets.only(top: 5, right: 14),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "قائمه المشتريات",
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                    textAlign: TextAlign.end,
                  )),
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            " / ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            order.ordersItems[index].size,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            " : ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            order.ordersItems[index].price.toInt().toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            " * ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            order.ordersItems[index].quantity
                                .toInt()
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            " = ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "${order.ordersItems[index].quantity.toInt() * order.ordersItems[index].price.toInt()}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Text(
                            "جنيه ",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: order.ordersItems.length,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: const DviderWithText(
                  text: "معلومات الطلب",
                  thickness: 2,
                  color: Colors.amber,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "العنوان  : ${order.location}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الهاتف  : ${order.phoneNumber}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "وقت الانشاء :    ${intl.DateFormat('MM/dd    الوقت h:mm ${timeDetailcreate == "AM" ? "صباحا" : "مسائا"}').format(order.createdAt)}   ",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.end,
                ),
              ),
              if (order.deliverdAt != null)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "وقت التاكيد :    ${intl.DateFormat('MM/dd    الوقت h:mm ${ timeDetailForconfirm == "AM" ? "صباحا" : "مسائا"} ').format(order.deliverdAt!)}   ",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.end,
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "الاجمالي :    ${order.totalPrice} جنيها   +   خدمة التوصيل",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "من فضلك لو في اي تأخير في التواصل مع حضرتك ممكن تكلمنا علي الرقم دا 01020766083",
                  style: TextStyle(color: Colors.amber, fontSize: 12),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
