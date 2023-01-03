import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/global_widgets/dvider_with_text.dart';
import 'package:on_the_bon/screens/order_screen/order_screen.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final Order order;

  get timeDetailcreate => intl.DateFormat("a").format(order.createdAt);

  get timeDetailForconfirm => intl.DateFormat("a").format(order.deliverdAt!);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 5)
        ],
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 5, right: 14),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الطلب : ${order.id}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: 5, right: 14),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "قائمه المشتريات",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderProductItem(
                  order: order,
                  index: index,
                  width: MediaQuery.of(context).size.width * .9,
                );
              },
              itemCount: order.ordersItems.length,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: const DviderWithText(
                text: "معلومات الطلب",
                thickness: 2,
                color: Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "العنوان  : ${order.location}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "رقم الهاتف  : ${order.phoneNumber}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "وقت الانشاء :    ${intl.DateFormat('MM/dd    الوقت h:mm ${timeDetailcreate == "AM" ? "صباحا" : "مسائا"}').format(order.createdAt)}   ",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            if (order.deliverdAt != null)
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "وقت التاكيد :    ${intl.DateFormat('MM/dd    الوقت h:mm ${timeDetailForconfirm == "AM" ? "صباحا" : "مسائا"} ').format(order.deliverdAt!)}   ",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "الاجمالي :    ${order.totalPrice} جنيها   +   خدمة التوصيل",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => OrderScreen(orderId: order.id)),
                  );
                },
                child: Text("الذهاب لصفحة الطلب"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProductItem extends StatelessWidget {
  const OrderProductItem(
      {Key? key, required this.order, required this.index, required this.width})
      : super(key: key);
  final int index;
  final Order order;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 2, bottom: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 5)
        ], color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: width * .35,
              child: Column(
                children: [
                  SizedBox(
                    width: width * .35,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: order.ordersItems[index].imageUrl,
                    ),
                  ),
                  Container(
                    width: width * .35,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      order.ordersItems[index].title,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("السعر : ${order.ordersItems[index].price}"),
                  Text("الكميه : ${order.ordersItems[index].quantity}"),
                  Text("الحجم : ${order.ordersItems[index].size}")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15, left: 5),
              width: 1,
              color: Colors.black,
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("الاجمالي"),
                  Text(
                      "${order.ordersItems[index].quantity * order.ordersItems[index].price} جنيها "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
