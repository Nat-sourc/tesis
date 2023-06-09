import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class principal extends StatelessWidget {
  const principal({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const SizedBox(height: 150),
                  
                  const Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                        height: 100.0,
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => {Navigator.of(context).pushNamed("/createPatient")},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text("Agregar paciente",
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Bold', fontSize: 20)),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                        height: 100.0,
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => {Navigator.of(context).pushNamed("/listPatient")},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text("Histórico de pacientes",
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Bold', fontSize: 20)),
                  ),
                ])),
          ],
        ));
  }
}
