import 'package:flutter/material.dart';
import 'package:on_the_bon/screens/home_screen/home_screen.dart';
import 'package:on_the_bon/screens/order_screen/order_screen.dart';

class SucessOrderScreen extends StatelessWidget {
  const SucessOrderScreen({super.key, required this.orderId});
  final String orderId;

  static String routeName = "success-order";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width * .7,
                child: Image.asset("assets/images/snoopy-congrats.gif")),
          ),
          Center(
            child: Text(
              "Congratulation",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                " لقد قمت بعمل طلب جديد وسيتم التواصل معك لتأكيد طلبك ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "permanentMarker"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 150),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                      child: Text("الصفحة الرئيسية"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      )),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 150),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderScreen(orderId: orderId)),
                      );
                    },
                    child: Text("متابعة طلبك"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
