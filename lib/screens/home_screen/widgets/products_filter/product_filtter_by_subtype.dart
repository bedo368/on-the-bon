import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';
import 'package:provider/provider.dart';

class ProductsFillterBySubType extends StatelessWidget {
  const ProductsFillterBySubType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subTypes = Provider.of<Products>(context).getSupTypes;
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Text(subTypes[index]);
        },
        itemCount: subTypes.length,
      ),
    );
  }
}
