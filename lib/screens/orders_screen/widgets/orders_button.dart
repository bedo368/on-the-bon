import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/clip_shadow.dart';
import 'package:on_the_bon/screens/home_screen/widgets/custom_clip_path.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({
    Key? key,
    required this.fetchOrderFunction,
  }) : super(key: key);

  final Function() fetchOrderFunction;

  static final ValueNotifier<OrderTypeEnum> activeOrders =
      ValueNotifier<OrderTypeEnum>(OrderTypeEnum.orderInProgres);

  @override
  Widget build(BuildContext context) {
    final List<String> buttonsText = orderTypeStringToEnum.keys.toList();
    return ClipShadowPath(
      shadow: BoxShadow(
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
          offset: const Offset(0, 5),
          spreadRadius: 5,
          color: Theme.of(context).primaryColor),
      clipper: WaveClip(lowPointPosition: 8, hightPointPosition: 16 ),
      child: Container(
        
        color: Colors.white,
        padding: const EdgeInsets.only(top: 25 , bottom: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 25,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return ValueListenableBuilder(
                        key: ValueKey(buttonsText[index]),
                        valueListenable: OrdersButton.activeOrders,
                        builder: (context, v, c) {
                          return GestureDetector(
                            onTap: () {
                              OrdersButton.activeOrders.value =
                                  orderTypeStringToEnum[buttonsText[index]]!;

                              fetchOrderFunction();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: v ==
                                                orderTypeStringToEnum[
                                                    buttonsText[index]]
                                            ? BorderSide(
                                                width: 1.0,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary)
                                            : const BorderSide(
                                                width: 0,
                                                color: Colors.white))),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  buttonsText[index],
                                  style: const TextStyle(color: Colors.black),
                                )),
                          );
                        },
                      );
                    }),
                    itemCount: 3,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
