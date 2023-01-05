import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/data/models/order.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/widgets/orders_item.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key, required this.orderId, required this.orderType});
  final String orderId;
  final OrderTypeEnum orderType;
  static String routeName = "order-screen";
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    String orderType;

    if (widget.orderType == OrderTypeEnum.orderInProgres) {
      orderType = "orderInProgres";
    } else if (widget.orderType == OrderTypeEnum.successfulOrder) {
      orderType = "sucessfulOrder";
    } else if (widget.orderType == OrderTypeEnum.rejectedOrder) {
      orderType = "rejectedOrder";
    } else {
      orderType = "orderInProgres";
    }

    Provider.of<Orders>(context, listen: false)
        .getOrderById(widget.orderId, orderType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Order or = Provider.of<Orders>(context).currOrder;
    final timeDetailcreate = intl.DateFormat("a").format(or.createdAt);

    // final timeDetailForconfirm = intl.DateFormat("a").format(or.deliverdAt!);

    print(or.phoneNumber);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "طلب رقم : ${or.id} ",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: or.id == ""
          ? SpinKitCircle(
              color: Colors.red,
            )
          : Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "قائمه المشتريات ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: or.ordersItems.length,
                      itemBuilder: (context, index) {
                        return OrderProductItem(
                          order: or,
                          index: index,
                          width: MediaQuery.of(context).size.width * .9,
                        );
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .95,
                      color: Colors.grey.withOpacity(.5),
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * .9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.5),
                                      offset: const Offset(2, 2),
                                      blurRadius: 3)
                                ],
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.9)),
                            width: MediaQuery.of(context).size.width * .43,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الاجمالي ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " ${or.totalPrice} جنيها + مصاريف الشحن",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.5),
                                      offset: const Offset(2, 2),
                                      blurRadius: 3)
                                ],
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.8)),
                            width: MediaQuery.of(context).size.width * .43,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "تاريخ الانشاء",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "  ${intl.DateFormat('yyyy/MM/dd  الساعة h:mm ${timeDetailcreate == "AM" ? "صباحا" : "مسائا"} ').format(or.createdAt)}  ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            offset: const Offset(2, 2),
                            blurRadius: 3)
                      ], color: Theme.of(context).primaryColor),
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "معلومات الاتصال",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Row(
                              children: [
                                Text(
                                  " رقم الهاتف : ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  or.phoneNumber,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              " العنوان : ${or.location} ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            width: MediaQuery.of(context).size.width * .95,
                            color: Colors.grey.withOpacity(.5),
                            height: 2,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              " هيتم التواصل مع حضرتك في خلال فتره قصيره من فضلك لو في اي مشكله في التواصل او الطلب تقدر تتصل بينا وسيتم حل المشكله بشكل فوري ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width * .9,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          var whatsappUrl = "tel://0472517754";
                          await launchUrl(Uri.parse(whatsappUrl));
                        },
                        icon: Icon(Icons.phone_callback),
                        label: Text(" اتصل بنا"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary),
                      ),
                    )
                  ],
                ),
              ),
            ),
    ));
  }
}
