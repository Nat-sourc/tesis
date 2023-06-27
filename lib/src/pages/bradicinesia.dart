import 'package:brainFit/src/components/titleImg.dart';
import 'package:flutter/material.dart';

class Bradicinesia extends StatelessWidget {

  const Bradicinesia({super.key});

  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 100.0,
                    )
                  ],
                ),
                const TitleImg(),
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 80.0,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/bradicinesia.png",
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 80.0,
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bradicinesis",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 50.0,
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Esta a punto de empezar el procedimiento de Bradicinesis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 50.0,
                    )
                  ],
                ),
                Text(
                  "ID del paciente: $parameterValue", // Impresión del idPatient
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'RobotoMono-Bold',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      "/taskFist",
                      arguments: parameterValue,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: const Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Comencemos",
                    style: TextStyle(
                      fontFamily: 'RobotoMono-Bold',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
