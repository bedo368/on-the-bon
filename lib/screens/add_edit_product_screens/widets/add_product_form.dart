import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';

import 'package:on_the_bon/screens/add_edit_product_screens/widets/size_price_selective.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    Key? key,
    // required this.currentPeoduct,
  }) : super(key: key);
  // final Product currentPeoduct;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    String id = "";
    String type = "";
    if (ModalRoute.of(context)!.settings.arguments != null) {
      id = (ModalRoute.of(context)!.settings.arguments as dynamic)['id'] ?? "";
      type =
          (ModalRoute.of(context)!.settings.arguments as dynamic)['type'] ?? "";
    }

    final Product currentPeoduct = Provider.of<Products>(context, listen: false)
        .fetchProductByTypeAndId(type: type, id: id);

    print("rerender");
    final List<ProductSizeEnum> sizeListEnum =
        productSizeStringtoEnum.keys.toList();

    final Map<String, double> priceSizeMap = {};
    void addPriceSize(ProductSizeEnum type, double price) {
      if (priceSizeMap.containsKey(productSizeStringtoEnum[type]!)) {
        priceSizeMap[productSizeStringtoEnum[type]!] = price;
      }
      priceSizeMap.putIfAbsent(productSizeStringtoEnum[type]!, () => price);
    }

    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: currentPeoduct?.title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 4) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: formInputDecortion("اسم المنتج", context),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: currentPeoduct?.discription,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 20) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    scrollController: ScrollController(),
                    textAlign: TextAlign.end,
                    decoration: formInputDecortion("الوصف", context),
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 10, left: 30),
                      child: const Text(
                        "النوع",
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<ProductsTypeEnum>(
                        items: productsStringToType.keys.map((value) {
                          return DropdownMenuItem(
                              value: productsStringToType[value]
                                  as ProductsTypeEnum,
                              child: Text(value));
                        }).toList(),
                        onChanged: (s) {},
                        value: productsStringToType[currentPeoduct!.type] ??
                            ProductsTypeEnum.hotDrinks,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: currentPeoduct!.subType,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 4) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: formInputDecortion("النوع الفرعي", context),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Text("الصوره")),
                    Expanded(
                      child: ImagePickerWedgit(
                        (pickedImage) {},
                        imageUrl: currentPeoduct!.imageUrl,
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: SizePriceSelective(
                      type: sizeListEnum[index],
                      addPriceWithSize: addPriceSize,
                    ),
                  );
                },
                itemCount: 3,
              ),
              Container(
                  height: 44,
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {},
                      // ignore: unnecessary_null_comparison
                      child: Text(currentPeoduct != null
                          ? "تعديل المنتج"
                          : " اضف المنتج")))
            ],
          ),
        ));
  }
}

InputDecoration formInputDecortion(
  String label,
  BuildContext context,
) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
    fillColor: const Color.fromARGB(255, 247, 243, 243),
    floatingLabelAlignment: FloatingLabelAlignment.center,
    labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
    filled: true,
    label: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(right: 5),
      child: Text(
        label,
        textAlign: TextAlign.end,
      ),
    ),
    focusColor: Colors.black,
    focusedBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
    ),
    enabledBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
  );
}
