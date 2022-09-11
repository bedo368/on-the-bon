import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:provider/provider.dart';

class CartScreenBottom extends StatelessWidget {
  const CartScreenBottom({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    String phoneNumber = "";
    String location = "";
    submitOrder() {
      print("unvalid");
      if (!formKey.currentState!.validate()) {
        return;
      }
      print(phoneNumber);
      formKey.currentState!.save();

      Provider.of<Orders>(context, listen: false).addOrder(
          orderItems: cartData.items.values.toList(),
          phoneNumber: phoneNumber,
          location: location,
          userId: Provider.of<User>(context, listen: false).uid);
      Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
    }

    return cartData.items.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: MediaQuery.of(context).size.width * .9,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "اجمالي الطلب : ${cartData.totalPrice.toInt()} جنيه ",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40, top: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            decoration: cartInput("رقم الهاتف"),
                            validator: ((value) {
                              if (value!.isNotEmpty) {
                                if (value.length != 11) {
                                  return "من فضلك  ادخل رقم هاتف صحيح";
                                } else if (int.tryParse(value) == null) {
                                  return "من فضلك  ادخل رقم هاتف صحيح";
                                }
                              }
                              if (value.isEmpty) {
                                return "من فضلك ادخل رقم هاتفك";
                              }
                              phoneNumber = value;
                              return null;
                            }),
                            onSaved: (newval) {
                              phoneNumber = newval!;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.right,
                          decoration: cartInput("العنوان"),
                          validator: ((value) {
                            if (value!.isNotEmpty) {
                              if (value.length <= 8) {
                                return " من فضلك  ادخل اسم الحي بشكل صحيح";
                              }
                            }
                            if (value.isEmpty) {
                              return "من فضلك  ادخل اسم الحي";
                            }
                            location = value;
                            return null;
                          }),
                          onSaved: (newval) {
                            location = newval!;
                          },
                          onFieldSubmitted: (_) async {
                            submitOrder();
                          },
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    print("object");
                    submitOrder();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 5)),
                  child: const Text("تأكيد الطلب"),
                ),
              )
            ]),
          )
        : SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                "العربه فارغه قم بملئها من فضلك",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
  }
}

InputDecoration cartInput(String label) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      fillColor: const Color.fromARGB(255, 247, 244, 244),
      filled: true,
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ));
}
