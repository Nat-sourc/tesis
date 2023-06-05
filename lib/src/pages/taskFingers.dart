import 'package:brainFit/src/components/titleImg.dart';
import 'package:brainFit/src/components/videoApp.dart';
import 'package:flutter/material.dart';

class TaskFingers extends StatelessWidget {
  const TaskFingers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
                  "assets/img/fingers.png",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tarea toque de dedos",
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
                      "Abrir y cerrar con los dedos de la mano",
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
            ElevatedButton(
                  onPressed: () async {
                    //await iniciarCamara();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed('/camera');
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