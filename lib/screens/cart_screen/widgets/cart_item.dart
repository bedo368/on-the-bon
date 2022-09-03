import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({Key? key}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            children: [
              Center(
                  child: Image.network(
                      "https://i.im.ge/2022/08/28/ONRPlD.pngwing-com.png")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.plus_one),
                    color: Theme.of(context).primaryColor,
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: Column(
            children: [
              Row(
                children: [],
              ),
              Container(),
            ],
          ),
        ),
      ]),
    );
  }
}
