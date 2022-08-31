import 'package:flutter/material.dart';

class PrdocutDiscription extends StatelessWidget {
  const PrdocutDiscription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text(
            ": الوصف",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              " قهوه تركي حوار فشخ اوعي تشتريها من عندنا  اجود انواع البن",
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

