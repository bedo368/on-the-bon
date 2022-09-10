import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/providers/porducts_provider.dart';

import 'package:on_the_bon/screens/add_product_screens/widets/size_price_selective.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    final List<ProductSizeEnum> sizeListEnum =
        productSizeStringtoEnum.keys.toList();

    final ValueNotifier<bool> isLoding = ValueNotifier<bool>(false);

    final Map<String, double> priceSizeMap = {};
    void addPriceSize(ProductSizeEnum type, double price) {
      if (priceSizeMap.containsKey(productSizeStringtoEnum[type]!)) {
        priceSizeMap[productSizeStringtoEnum[type]!] = price;
      }
      priceSizeMap.putIfAbsent(productSizeStringtoEnum[type]!, () => price);
    }

    final Map<String, dynamic> formData = {
      "title": "",
      "discription": "",
      "subType": "",
      "type": "",
      "image": File(""),
    };

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _formSubmit() async {
      try {
        if (!formKey.currentState!.validate()) {
          return;
        } else if (formKey.currentState!.validate()) {
          if (priceSizeMap.isEmpty) {
            return;
          }
          if ((formData["image"] as File).path == "") {
            return;
          }
          if (formData["type"] == "") {
            return;
          }
          final newProductData = Product(
              id: "",
              title: formData["title"],
              discription: formData["discription"],
              sizePrice: priceSizeMap,
              type: formData["type"],
              subType: formData["subType"],
              imageUrl: "");
          await Provider.of<Products>(context, listen: false)
              .createNewProduct(newProductData, formData["image"]);
        }
      } catch (error) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "حدث خطا ما يرجي المحاوله مجددا",
                textAlign: TextAlign.center,
              ),
            )));
        isLoding.value = false;

        rethrow;
      }

      isLoding.value = false;
    }

    return Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 3) {
                        return "اسم المنتج قصير للغايه ";
                      }
                      formData["title"] = value;

                      return null;
                    },
                    onSaved: (value) {
                      formData["title"] = value;
                    },
                    textAlign: TextAlign.end,
                    decoration: formInputDecortion("اسم المنتج", context),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 20) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      formData["discription"] = value;
                      return null;
                    },
                    onSaved: (value) {
                      formData["discription"] = value;
                    },
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
                        onChanged: (value) {
                          formData["type"] = productsTypeToString[value];
                        },
                        onSaved: (value) {
                          print(value);
                          formData["type"] = productsTypeToString[value];
                        },
                        value: null,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل النوع الفرعي للمنتج";
                      } else if (value.length < 4) {
                        return "النوع الفرعي قصير للغايه ";
                      }
                      formData["subType"] = value;

                      return null;
                    },
                    onSaved: (value) {
                      formData["subType"] = value;
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
                        (pickedImage) {
                          formData["image"] = pickedImage;
                        },
                        imageUrl: null,
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
              ValueListenableBuilder<bool>(
                valueListenable: isLoding,
                builder: (context, value, child) {
                  return Container(
                      height: 44,
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * .8,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: value
                              ? null
                              : () async {
                                  isLoding.value = true;
                                  await _formSubmit();
                                },
                          // ignore: unnecessary_null_comparison
                          child: value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("اضف المنتج")));
                },
              )
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
