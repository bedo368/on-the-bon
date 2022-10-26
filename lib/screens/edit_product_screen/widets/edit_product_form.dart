import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/data/providers/porducts_provider.dart';
import 'package:on_the_bon/screens/edit_product_screen/widets/size_price_selective.dart';
import 'package:on_the_bon/screens/product_screen/product_screen.dart';

import 'package:on_the_bon/type_enum/enums.dart';
import 'package:provider/provider.dart';

class EditProductFrom extends StatelessWidget {
  const EditProductFrom({
    Key? key,
  }) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String id = "";
    if (ModalRoute.of(context)!.settings.arguments != null) {
      id = (ModalRoute.of(context)!.settings.arguments as dynamic)['id'] ?? "";
    }
    final ValueNotifier<bool> isLoding = ValueNotifier<bool>(false);
    final Map<String, dynamic> formData = {
      "title": "",
      "discription": "",
      "subType": "",
      "type": "",
      "image": File(""),
    };

    final Product currentPeoduct =
        Provider.of<Products>(context, listen: false).fetchProductById(id: id);

    final List<ProductSizeEnum> sizeListEnum =
        productSizeStringtoEnum.keys.toList();

    void addPriceSize(ProductSizeEnum type, double price) {
      if (currentPeoduct.sizePrice
          .containsKey(productSizeStringtoEnum[type]!)) {
        currentPeoduct.sizePrice[productSizeStringtoEnum[type]!] = price;
      }
      currentPeoduct.sizePrice
          .putIfAbsent(productSizeStringtoEnum[type]!, () => price);
    }

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _formSubmit() async {
      try {
        formKey.currentState!.save();
        formData["image"] = ImagePickerWedgit.imageHolder ?? File("");
        if (!formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "يرجي ملئ معلومات المنتج",
                  textAlign: TextAlign.center,
                ),
              )));
          isLoding.value = false;

          return;
        } else if (formKey.currentState!.validate()) {
          final newProductData = Product(
              id: currentPeoduct.id,
              title: formData["title"],
              discription: formData["discription"],
              sizePrice: currentPeoduct.sizePrice,
              type: formData["type"],
              subType: formData["subType"],
              imageUrl: currentPeoduct.imageUrl);

          await Provider.of<Products>(context, listen: false)
              .editProduct(product: newProductData, image: formData["image"]);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacementNamed(ProductScreen.routeName,
              arguments: {"id": newProductData.id});
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
                    initialValue: currentPeoduct.title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 4) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      formData['title'] = newValue;
                    },
                    decoration: formInputDecortion("اسم المنتج", context),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: currentPeoduct.discription,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 20) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      formData['discription'] = newValue;
                    },
                    scrollController: ScrollController(),
                    decoration: formInputDecortion("الوصف", context),
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 10, left: 30),
                      child: const Text(
                        "النوع",
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
                        onSaved: (newValue) {
                          formData['type'] = productsTypeToString[newValue];
                        },
                        value: productsStringToType[currentPeoduct.type],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    initialValue: currentPeoduct.subType,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل اسم المنتج";
                      } else if (value.length < 4) {
                        return "اسم المنتج قصير للغايه ";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      formData['subType'] = newValue;
                    },
                    decoration: formInputDecortion("النوع الفرعي", context),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Text("الصوره")),
                    Expanded(
                      child: ImagePickerWedgit(
                        imageQulity: 100,
                        (pickedImage) {
                          ImagePickerWedgit.imageHolder = pickedImage;

                          formData["image"] = pickedImage;
                        },
                        imageUrl: currentPeoduct.imageUrl,
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
                      price: currentPeoduct.sizePrice[
                              productSizeStringtoEnum[sizeListEnum[index]]] ??
                          0,
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
                              : const Text("تعديل المنتج")));
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
