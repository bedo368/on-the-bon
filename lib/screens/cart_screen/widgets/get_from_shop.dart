import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:on_the_bon/screens/cart_screen/widgets/bottom_cart_screen.dart';

class SetToGetFromShop extends StatefulWidget {
  const SetToGetFromShop({
    Key? key,
    required this.switchFunction,
    required this.shopName,
    required this.onSubmit,
  }) : super(key: key);

  final Function(bool) switchFunction;
  final String shopName;
  final Function(String) onSubmit;

  @override
  State<SetToGetFromShop> createState() => _SetToGetFromShopState();
}

class _SetToGetFromShopState extends State<SetToGetFromShop> {
  bool isDelevary = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
              child: Transform.rotate(
                  angle: pi / 2,
                  child: Transform.scale(
                    scale: .8,
                    child: CupertinoSwitch(
                      value: isDelevary,
                      onChanged: (value) {
                        setState(() {
                          isDelevary = value;
                        });
                        widget.switchFunction(value);
                      },
                    ),
                  )),
            ),
            Text(
              "استلم من فرع ${widget.shopName} في خلال ",
            ),
            isDelevary
                ? Container(
                    width: 70,
                    margin: EdgeInsets.only(left: 5),
                    child: TextFormField(
                      decoration: cartInput("المده"),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) {
                        if (value!.isNotEmpty) {
                          if (value.length <= 0) {
                            return "من فضلك ادخل المد التي تريد الاستلام خلالها ";
                          }
                        }
                        if (value.isEmpty) {
                          return "من فضلك ادخل المد التي تريد الاستلام خلالها";
                        }
                        // locationText = value;
                        return null;
                      }),
                      onSaved: (newval) {
                        widget.onSubmit(
                            'استلم من فرع ${widget.shopName} في خلال ${newval} دقيقه');
                        // locationText = newval!;
                      },
                    ),
                  )
                : Container(),
            isDelevary
                ? Text(
                    "دقيقه",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
