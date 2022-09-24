import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/data/helper/auth.dart';
import 'package:on_the_bon/data/providers/cart_provider.dart';
import 'package:on_the_bon/data/providers/orders_provider.dart';
import 'package:on_the_bon/data/providers/user_provider.dart';
import 'package:on_the_bon/screens/orders_screen/orders_screen.dart';
import 'package:provider/provider.dart';

class CartScreenBottom extends StatefulWidget {
  const CartScreenBottom({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static ValueNotifier<bool> usingCurrentPhone = ValueNotifier(true);

  @override
  State<CartScreenBottom> createState() => _CartScreenBottomState();
}

class _CartScreenBottomState extends State<CartScreenBottom> {
  @override
  void initState() {
    CartScreenBottom.usingCurrentPhone.value = true;

    super.initState();
  }

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    String phoneNumber = "";
    String locationText = "";
    Future<void> addOrder(BuildContext context, String phone) async {
      try {
        isLoading.value = true;

        await Provider.of<Orders>(context, listen: false).addOrder(
            orderItems: Provider.of<Cart>(context, listen: false).cartItems,
            phoneNumber: phone,
            location: locationText,
            totalPrice: Provider.of<Cart>(context, listen: false).totalPrice,
            userId: Provider.of<User>(context, listen: false).uid);

        // ignore: use_build_context_synchronously
        Provider.of<Cart>(context, listen: false).clearCart();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);

        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(" حدث خطا ما من فضلك حاول مجددا")));
        isLoading.value = false;

        rethrow;
      }
    }

    submitOrder() async {
      isLoading.value = true;

      if (!CartScreenBottom.formKey.currentState!.validate()) {
        isLoading.value = false;

        return;
      }
      CartScreenBottom.formKey.currentState!.save();

      if (Provider.of<UserData>(context, listen: false).phoneNumber != null &&
          CartScreenBottom.usingCurrentPhone.value) {
        try {
          phoneNumber = Provider.of<UserData>(context, listen: false)
              .phoneNumber as String;

          await addOrder(context, phoneNumber);
          isLoading.value = false;

          return;
        } catch (e) {
          isLoading.value = false;

          rethrow;
        }
      }

      Future retry() async {
        await Auth.verifyPhoneNumber(
            onCancel: () {
              Navigator.of(context).pop();
              isLoading.value = false;
            },
            phoneNumber: phoneNumber,
            location: locationText,
            context: context,
            confirmOrder: (context) async {
              try {
                await addOrder(context, phoneNumber);
              } catch (e) {
                isLoading.value = false;
                rethrow;
              }
            });
      }

      try {
        await Auth.verifyPhoneNumber(
            onCancel: () {
              Navigator.of(context).pop();
              isLoading.value = false;
            },
            retry: retry,
            phoneNumber: phoneNumber,
            location: locationText,
            context: context,
            confirmOrder: (context) async {
              try {
                await addOrder(context, phoneNumber);
                isLoading.value = false;
              } catch (e) {
                isLoading.value = false;
                rethrow;
              }
            });
      } catch (e) {
        isLoading.value = false;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: MediaQuery.of(context).size.width * .9,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          child: Text(
            "اجمالي الطلب : ${Provider.of<Cart>(context, listen: false).totalPrice.toInt()} جنيه ",
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Form(
            key: CartScreenBottom.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40, top: 10),
              child: Column(
                children: [
                  if (Provider.of<UserData>(context, listen: false)
                          .phoneNumber !=
                      null)
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          const Text(" : رقم الهاتف الحالي  "),
                          Text(
                            Provider.of<UserData>(context, listen: false)
                                .phoneNumber
                                .toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {});
                                CartScreenBottom.usingCurrentPhone.value =
                                    !CartScreenBottom.usingCurrentPhone.value;
                              },
                              child: ValueListenableBuilder<bool>(
                                  valueListenable:
                                      CartScreenBottom.usingCurrentPhone,
                                  builder: (context, value, child) {
                                    return Text(value
                                        ? "تغير الهاتف"
                                        : "استخدام الرقم");
                                  }))
                        ],
                      ),
                    ),
                  if (Provider.of<UserData>(context, listen: false)
                              .phoneNumber ==
                          null ||
                      !CartScreenBottom.usingCurrentPhone.value)
                    ValueListenableBuilder<bool>(
                        valueListenable: CartScreenBottom.usingCurrentPhone,
                        builder: (context, value, child) {
                          return !value ||
                                  Provider.of<UserData>(context, listen: false)
                                          .phoneNumber ==
                                      null
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    decoration: cartInput("رقم الهاتف"),
                                    validator: ((value) {
                                      if (value!.isNotEmpty) {
                                        if (value.length != 11) {
                                          return "من فضلك  ادخل رقم هاتف صحيح";
                                        } else if (int.tryParse(value) ==
                                            null) {
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
                                )
                              : Container();
                        }),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: TextFormField(
                          initialValue:
                              Provider.of<UserData>(context, listen: false)
                                      .location ??
                                  "",
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
                            locationText = value;
                            return null;
                          }),
                          onSaved: (newval) {
                            locationText = newval!;
                          },
                          onFieldSubmitted: (_) async {
                            await submitOrder();
                          },
                        ),
                      ),
                      const Icon(
                        Icons.location_pin,
                      ),
                    ],
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
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 5)),
                child: value
                    ? const Center(
                        child: SpinKitPulse(
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
    );
  }
}

InputDecoration cartInput(String label) {
  return InputDecoration(
      contentPadding:
          const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      fillColor: const Color.fromARGB(255, 247, 244, 244),
      filled: true,
      hintText: label,
      hintTextDirection: TextDirection.rtl,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.white),
      ));
}








 // await showConfirmDialog(
      //     content:
      //         "  هل انت متاكد من اضافة طلب جديد علي رقم التواصل $phoneNumber",
      //     title: "اضافة طلب ",
      //     confirmText: "اضافه",
      //     cancelText: "الغاء",
      //     context: context,
      //     onConfirm: () async {
      //       try {
      //         await Provider.of<Orders>(context, listen: false).addOrder(
      //             orderItems: cartData.items.values.toList(),
      //             phoneNumber: phoneNumber,
      //             location: location,
      //             totalPrice:
      //                 Provider.of<Cart>(context, listen: false).totalPrice,
      //             userId: Provider.of<User>(context, listen: false).uid);

      //         // ignore: use_build_context_synchronously
      //         Provider.of<Cart>(context, listen: false).clearCart();

      //         // ignore: use_build_context_synchronously
      //         Navigator.of(context)
      //             .pushReplacementNamed(OrdersScreen.routeName);

      //         isLoading.value = false;
      //       } catch (e) {
      //         isLoading.value = false;

      //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //             content: Text(" حدث خطا ما من فضلك حاول مجددا")));

      //         rethrow;
      //       }
      //     },
      //     onCancel: () {});