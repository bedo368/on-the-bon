import 'package:flutter/material.dart';
import 'package:on_the_bon/data/providers/product.dart';

class MySearchDelegate extends SearchDelegate {
  final List<Product> products;
  final Function(BuildContext context, String id, String) onElementTap;
  MySearchDelegate(this.products, this.onElementTap);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == "") {
              close(context, null);
            }
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> filterdProduct = products.where((element) {
      final input = query;
      return element.title.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(filterdProduct[index].title),
          onTap: () {
            query = filterdProduct[index].title;

            onElementTap(
                context, filterdProduct[index].id, filterdProduct[index].type);
          },
        );
      },
      itemCount: filterdProduct.length,
    );
  }
}
