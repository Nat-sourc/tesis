import 'package:flutter/material.dart';

import '../components/titleImg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonBradicinesis extends StatefulWidget {
  const ButtonBradicinesis({super.key});

  @override
  State<ButtonBradicinesis> createState() => _ButtonBradicinesisState();
}

class _ButtonBradicinesisState extends State<ButtonBradicinesis> {
  bool isTaskEnabled = true;
  bool isEnabled = true;
  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;

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
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('pacientes')
                      .doc(parameterValue)
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(parameterValue);
                    if (snapshot.hasData) {
                      final paciente = snapshot.data;

                      final task = paciente?['completeTaskBradicinesis'];
                      if (task == true) {
                        isTaskEnabled = false;
                        print("no llego");
                      }

                      return ElevatedButton(
                        onPressed: isTaskEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/bradicinesia",
                                  arguments: parameterValue,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 191, 166),
                          minimumSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          "Empezar Pruebas",
                          style: TextStyle(
                            fontFamily: 'RobotoMono-Bold',
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 50.0,
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: isEnabled
                        ? () {
                            Navigator.of(context).pushNamed(
                              "/uploadVideoBradicinesis",
                              arguments: parameterValue,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Subir Prueba",
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