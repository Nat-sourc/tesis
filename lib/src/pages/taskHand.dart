import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/titleImg.dart';

class TaskHand extends StatefulWidget {
  const TaskHand({super.key});

  @override
  State<TaskHand> createState() => _TaskHandState();
}

class _TaskHandState extends State<TaskHand> {
  @override
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/third.png",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Movimientos de supinación de las manos",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 20))
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
                      "Posicione el brazo como se muestra en el video, gire la palma de la mano hacia atrás y adelante alternativamente 10 veces, tan rápido y completamente como sea posible",
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
                    Navigator.of(context).pushNamed('/cameraHand', arguments: parameterValue);
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