import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/global_widgets/confirm_dialog.dart';

import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/global_widgets/dvider_with_text.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class OrderManageItem extends StatefulWidget {
  const OrderManageItem({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  State<OrderManageItem> createState() => _OrderManageItemState();
}

class _OrderManageItemState extends State<OrderManageItem> {
  late final Map userInfo;
  Future getUserData(String userId) async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    userInfo = {
      "userId": userData.id,
      "name": userData.data()!["displayName"] ?? "",
      "imageUrl": userData.data()!["photoURL"] ?? ""
    };
    setState(() {
      userDataLoading = true;
    });
  }

  bool userDataLoading = false;
  @override
  void initState() {
    getUserData(widget.order.userId);
    super.initState();
  }

  get timeDetailcreate => intl.DateFormat("a").format(widget.order.createdAt);

  get timeDetailForconfirm =>
      intl.DateFormat("a").format(widget.order.deliverdAt!);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
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
            if (userDataLoading)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            userInfo["imageUrl"],
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        userInfo["name"],
                        style: const TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                ),
              ),
            Container(
                margin: const EdgeInsets.only(top: 5, right: 14),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الطلب : ${widget.order.id}",
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
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(right: 2, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            offset: const Offset(3, 3),
                            blurRadius: 5)
                      ], color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 70,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: widget
                                        .order.ordersItems[index].imageUrl,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    widget.order.ordersItems[index].title,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
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
                                Text(
                                    "السعر : ${widget.order.ordersItems[index].price}"),
                                Text(
                                    "الكميه : ${widget.order.ordersItems[index].quantity}"),
                                Text(
                                    "الحجم : ${widget.order.ordersItems[index].size}")
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
                                    "${widget.order.ordersItems[index].quantity * widget.order.ordersItems[index].price} جنيها "),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.order.ordersItems.length,
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
                "العنوان  : ${widget.order.location}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "رقم الهاتف  : ${widget.order.phoneNumber}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "وقت الانشاء :    ${intl.DateFormat('MM/dd    الوقت h:mm ${timeDetailcreate == "AM" ? "صباحا" : "مسائا"}').format(widget.order.createdAt)}   ",
                style: const TextStyle(fontSize: 15),
              ),
            ),
            if (widget.order.deliverdAt != null)
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "وقت التاكيد :    ${intl.DateFormat('MM/dd    الوقت h:mm ${timeDetailForconfirm == "AM" ? "صباحا" : "مسائا"} ').format(widget.order.deliverdAt!)}   ",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "الاجمالي :    ${widget.order.totalPrice} جنيها   +   خدمة التوصيل",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      showConfirmDialog(
                          content:
                              " هل انت متاكد اضافه الطلب الي الطلبات الناجحه",
                          title: "تاكيد اضافه الطلب",
                          confirmText: "تاكيد",
                          cancelText: "الغاء",
                          context: context,
                          onConfirm: () async {
                            await Provider.of<Orders>(context, listen: false)
                                .cahngeOrderType(
                                    newtype: OrderTypeEnum.successfulOrder,
                                    orderId: widget.order.id,
                                    oldType: widget.order.orderType);
                          },
                          onCancel: () {});
                    },
                    child: const Text(
                      "طلب ناجح",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    showConfirmDialog(
                        content:
                            " هل انت متاكد اضافه الطلب الي الطلبات المرفوضه",
                        title: "تاكيد اضافه الطلب",
                        confirmText: "تاكيد",
                        cancelText: "الغاء",
                        context: context,
                        onConfirm: () async {
                          await Provider.of<Orders>(context, listen: false)
                              .cahngeOrderType(
                                  newtype: OrderTypeEnum.rejectedOrder,
                                  orderId: widget.order.id,
                                  oldType: widget.order.orderType);
                        },
                        onCancel: () {});
                  },
                  child: const Text(
                    "طلب مرفوض",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
