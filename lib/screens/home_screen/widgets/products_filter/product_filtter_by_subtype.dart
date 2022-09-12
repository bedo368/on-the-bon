import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductsFillterBySubType extends StatelessWidget {
  const ProductsFillterBySubType({Key? key}) : super(key: key);
  static final ValueNotifier<String> subType = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    final subTypes = Provider.of<Products>(context).getSupTypes;
    subType.value =
        Provider.of<Products>(context, listen: false).currentSubType;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 40,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                    valueListenable: ProductsFillterBySubType.subType,
                    builder: (context, v, c) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<Products>(context, listen: false)
                              .setSubYype(subTypes[index]);
                          ProductsFillterBySubType.subType.value =
                              Provider.of<Products>(context, listen: false)
                                  .currentSubType;
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: v == subTypes[index]
                                        ? BorderSide(
                                            width: 1.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)
                                        : const BorderSide(
                                            width: 0, color: Colors.white))),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              subTypes[index],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              textAlign: TextAlign.center,
                            )),
                      );
                    });
              },
              itemCount: subTypes.length,
            ),
          ],
        ),
      ),
    );
  }
}
