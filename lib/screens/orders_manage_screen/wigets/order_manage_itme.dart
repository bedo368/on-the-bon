import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:on_the_bon/global_widgets/confirm_dialog.dart';

import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class OrderManageItem extends StatefulWidget {
  const OrderManageItem({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  State<OrderManageItem> createState() => _OrderManageItemState();
}

class _OrderManageItemState extends State<OrderManageItem> {
  late final UserInfo;
  Future getUserData(String userId) async {
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    UserInfo = {
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
              if (userDataLoading)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              UserInfo["imageUrl"],
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          UserInfo["name"],
                          style: TextStyle(color: Colors.amber),
                        ),
                      )
                    ],
                  ),
                ),
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
                            widget.order.ordersItems[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " / ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.order.ordersItems[index].size,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.order.ordersItems[index].price
                                .toInt()
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " * ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.order.ordersItems[index].quantity
                                .toInt()
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Text(
                            " = ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${widget.order.ordersItems[index].quantity.toInt() * widget.order.ordersItems[index].price.toInt()}",
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
                itemCount: widget.order.ordersItems.length,
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
                  "العنوان  : ${widget.order.location}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الهاتف  : ${widget.order.phoneNumber}",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "وقت الانشاء :    ${intl.DateFormat('MM/dd    الوقت hh:mm').format(widget.order.createdAt)}   ",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.end,
                ),
              ),
              if (widget.order.deliverdAt != null)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "وقت التاكيد :    ${intl.DateFormat('MM/dd    الوقت hh:mm').format(widget.order.deliverdAt!)}   ",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.end,
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "الاجمالي :    ${widget.order.totalPrice} جنيها   +   خدمة التوصيل",
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              ),
              Row(
                children: [
                  TextButton(
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
                        style: TextStyle(color: Colors.amber),
                      )),
                  TextButton(
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
