import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/type_enum/enums.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: formInputDecortion("اسم المنتج", context),
                )),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
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
                            value:
                                productsStringToType[value] as ProductsTypeEnum,
                            child: Text(value));
                      }).toList(),
                      onChanged: (s) {},
                      value: ProductsTypeEnum.hotDrinks,
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  textAlign: TextAlign.end,
                  decoration: formInputDecortion("النوع الفرعي", context),
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Text("الصوره")),
                  Expanded(
                    child: ImagePickerWedgit(
                      (pickedImage) {},
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 20),
            //   width: MediaQuery.of(context).size.width * .8,
            //   child: Expanded(
            //     child: AnimatedList(
            //       primary: false,
            //       shrinkWrap: true,
            //       itemBuilder: (context, index, animation) {
            //         return Expanded(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            //               Container(
            //                   width: 70,
            //                   margin: EdgeInsets.symmetric(horizontal: 5),
            //                   child: Expanded(child: TextFormField())),
            //               Container(
            //                 width: 70,
            //                 margin: EdgeInsets.symmetric(horizontal: 5),
            //                 child: Expanded(
            //                   child: DropdownButtonFormField<ProductSizeEnum>(
            //                     items:
            //                         productSizeEnumToString.keys.map((value) {
            //                       return DropdownMenuItem(
            //                           value: productSizeEnumToString[value],
            //                           child: Expanded(child: Text(value)));
            //                     }).toList(),
            //                     onChanged: (s) {},
            //                     value: ProductSizeEnum.small,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //       initialItemCount: 1,
            //     ),
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}

InputDecoration formInputDecortion(
  String label,
  BuildContext context,
) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      fillColor: Color.fromARGB(255, 247, 243, 243),
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
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Color.fromARGB(255, 141, 39, 39)),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide(color: Color.fromARGB(255, 102, 14, 14)),
      ));
}
