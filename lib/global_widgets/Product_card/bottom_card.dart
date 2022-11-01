import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:on_the_bon/global_widgets/animated_widgets/animated_cart.dart';
import 'package:on_the_bon/screens/cart_screen/cart_screen.dart';
import 'package:provider/provider.dart';

class BottomCard extends StatefulWidget {
  const BottomCard({
    Key? key,
    required this.sizePrice,
    required this.title,
    required this.id,
    required this.imagUrl,
    required this.type,
  }) : super(key: key);
  final String title;
  final String id;
  final String type;
  final Map<String, double> sizePrice;
  final String imagUrl;

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  @override
  Widget build(BuildContext context) {
    String size = widget.sizePrice.keys.first;
    double price = widget.sizePrice[size] as double;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
          margin: const EdgeInsets.only(top: 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "السعر : $price",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: AnimatedCart(
                          presssed: () {
                            Provider.of<Cart>(context, listen: false)
                                .addItemToCartWithQuntity(
                                    title: widget.title,
                                    id: widget.id,
                                    price: price,
                                    imageUrl: widget.imagUrl,
                                    type: widget.type,
                                    size: size);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5.0, sigmaY: 5.0),
                                    child: AlertDialog(
                                      title: const Text(
                                        "تمت اضافة المنتج الي العربه",
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "متابعة التسوق",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          CartScreen.routeName);
                                                },
                                                child: const Text(
                                                  "الذهاب الي العربه",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // if (widget.sizePrice.length > 1)
                //   Container(
                //     padding: const EdgeInsets.only(bottom: 10),
                //     width: MediaQuery.of(context).size.width,
                //     height: 40,
                //     child: Center(
                //       child: ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: const EdgeInsets.only(left: 10),
                //             width: 80,
                //             height: 28,
                //             child: ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     primary: size == ""
                //                         ? Theme.of(context)
                //                             .colorScheme
                //                             .secondary
                //                         : Colors.grey,
                //                     padding: const EdgeInsets.all(0),
                //                     textStyle: const TextStyle(fontSize: 10)),
                //                 onPressed: () {},
                //                 child: Text(sizesList[index])),
                //           );
                //         },
                //         itemCount: widget.sizePrice.length,
                //       ),
                //     ),
                //   )
              ],
            ),
          )),
    );
  }
}
