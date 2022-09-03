import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
    required this.sizePrice,
    required this.title,
    required this.id,
  }) : super(key: key);
  final String title;
  final String id;
  final Map<String, double> sizePrice;

  @override
  Widget build(BuildContext context) {
    String size = sizePrice.keys.first;
    double price = sizePrice[size] as double;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
          margin: const EdgeInsets.only(top: 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 35,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            "السعر : $price",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
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
