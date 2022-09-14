import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:provider/provider.dart';

class CartScreenBottom extends StatelessWidget {
  const CartScreenBottom({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier(false);
    final cartData = Provider.of<Cart>(context);

    String phoneNumber = "";
    String location = "";
    submitOrder() async {
      isLoading.value = true;
      if (!formKey.currentState!.validate()) {
        isLoading.value = false;

        return;
      }
      formKey.currentState!.save();

      try {
        await Provider.of<Orders>(context, listen: false).addOrder(
            orderItems: cartData.items.values.toList(),
            phoneNumber: phoneNumber,
            location: location,
            totalPrice: Provider.of<Cart>(context, listen: false).totalPrice,
            userId: Provider.of<User>(context, listen: false).uid);

        isLoading.value = false;
        // ignore: use_build_context_synchronously
        Provider.of<Cart>(context, listen: false).clearCart();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
      } catch (e) {
        isLoading.value = false;
        rethrow;
      }
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
              ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: value
                          ? null
                          : () async {
                              await submitOrder();
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 5)),
                      child: value
                          ? const Center(
                              child: SpinKitPouringHourGlassRefined(
                                color: Colors.green,
                                size: 30,
                              ),
                            )
                          : const Text("تأكيد الطلب"),
                    ),
                  );
                },
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
