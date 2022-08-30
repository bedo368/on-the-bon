import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/Product_card/bottom_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, required this.imageUrl, this.haveMultiSize = false})
      : super(key: key);
  final String imageUrl;
  final bool? haveMultiSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: Card(
                        margin: const EdgeInsets.only(bottom: 0),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                        color: const Color.fromRGBO(249, 242, 246, 1),
                        child: Column(
                          children: [Container()],
                        )),
                  ),
                  BottomCard(haveMultiSize: haveMultiSize),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Image.network(
              imageUrl,
              height: 170,
            ),
          ),
        ],
      ),
    );
  }
}
