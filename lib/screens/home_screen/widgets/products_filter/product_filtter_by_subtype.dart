import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder<String>(
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AnimatedContainer(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.5,
                                            color: v == subTypes[index]
                                                ? Theme.of(context).primaryColor
                                                : Colors.white))),
                                child: Center(
                                  child: Text(
                                    subTypes[index],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  itemCount: subTypes.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
