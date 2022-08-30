import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/product_size.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
    required this.haveMultiSize,
  }) : super(key: key);

  final bool? haveMultiSize;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Row(
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
                    Expanded(
                        child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "قهوه",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              "السعر : 15",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                if (haveMultiSize == true) const ProductSize()
              ],
            ),
          )),
    );
  }
}
