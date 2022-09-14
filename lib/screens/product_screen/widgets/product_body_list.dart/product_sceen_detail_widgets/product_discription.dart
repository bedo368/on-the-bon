import 'package:flutter/material.dart';

class PrdocutDiscription extends StatelessWidget {
  const PrdocutDiscription({
    Key? key,
    required this.discription,
  }) : super(key: key);
  final String discription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            ": الوصف",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          Text(
            discription,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
