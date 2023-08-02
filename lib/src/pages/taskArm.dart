import 'package:flutter/material.dart';

import '../components/titleImg.dart';

class TaskArm extends StatelessWidget {
  const TaskArm({super.key});

  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
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
                  height: 10.0,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/brazo.jpg",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tarea Brazo",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 30))
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
                      "Mueva la mano con este movimiento",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 18)),
                )
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
                  onPressed: () async {
                    //await iniciarCamara();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed('/CameraArm', arguments: parameterValue);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: Size(350, 50),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text("Comencemos",
                      style: TextStyle(
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 20)), 
                ),
      ]),
      ),
    );
  }
}
