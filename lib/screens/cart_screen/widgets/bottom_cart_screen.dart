import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_the_bon/global_widgets/icon_gif.dart';
import 'package:on_the_bon/helper/auth.dart';
import 'package:on_the_bon/providers/cart_provider.dart';
import 'package:on_the_bon/providers/orders_provider.dart';
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
    // TODO: implement initState
    CartScreenBottom.usingCurrentPhone.value = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier(false);
    final cartData = Provider.of<Cart>(context);
    String phoneNumber = "";
    String location = "";
    Future<void> addOrder(BuildContext context, String phone) async {
      try {
        isLoading.value = true;

        await Provider.of<Orders>(context, listen: false).addOrder(
            orderItems: cartData.cartItems,
            phoneNumber: phone,
            location: location,
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

      if (Provider.of<User>(context, listen: false).phoneNumber != null &&
          CartScreenBottom.usingCurrentPhone.value) {
        try {
          phoneNumber =
              Provider.of<User>(context, listen: false).phoneNumber as String;

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
            location: location,
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
            location: location,
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

    return cartData.cartItems.isNotEmpty
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
                  key: CartScreenBottom.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40, top: 10),
                    child: Column(
                      children: [
                        if (Provider.of<User>(context, listen: false)
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
                                  Provider.of<User>(context, listen: false)
                                      .phoneNumber
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      CartScreenBottom.usingCurrentPhone.value =
                                          !CartScreenBottom
                                              .usingCurrentPhone.value;
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
                        if (Provider.of<User>(context).phoneNumber == null ||
                            !CartScreenBottom.usingCurrentPhone.value)
                          ValueListenableBuilder<bool>(
                              valueListenable:
                                  CartScreenBottom.usingCurrentPhone,
                              builder: (context, value, child) {
                                return !value ||
                                        Provider.of<User>(context)
                                                .phoneNumber ==
                                            null
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.end,
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
                            await submitOrder();
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
          )
        : const IconGif(
            width: 150,
            content: "العربه فارغه قم بملئها من فضلك",
            iconPath: "assets/images/emptycart.gif");
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