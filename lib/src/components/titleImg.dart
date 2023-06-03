import 'package:flutter/material.dart';

class TitleImg extends StatelessWidget {
  const TitleImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/img/hospital.png",
          height: 50,
          width: 50,
        ),
        const SizedBox(
          width: 30.0,
          height: 30.0,
        ),
        const Text("BrainFit",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 191, 166),
                fontFamily: 'RobotoMono-Bold',
                fontSize: 30))
      ],
    );
  }
}
