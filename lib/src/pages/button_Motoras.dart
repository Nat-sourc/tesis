import 'package:flutter/material.dart';
import '../components/titleImg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonMotoras extends StatefulWidget {
  const ButtonMotoras({Key? key}) : super(key: key);

  @override
  State<ButtonMotoras> createState() => _ButtonMotorasState();
}

class _ButtonMotorasState extends State<ButtonMotoras> {
  bool isTaskAudioEnabled = true;
  bool isTaskMarchaEnabled = true;
  bool isTaskDualTaskEnabled = true;

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

                      final taskAudio = paciente?['taskaudio'];
                      final taskMarcha = paciente?['taskmarcha'];
                      final dualTask = paciente?['dualtask'];

                      if (taskAudio == true) {
                        isTaskAudioEnabled = false;
                        print("no llego");
                      }

                      return ElevatedButton(
                        onPressed: isTaskAudioEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/taskMarcha",
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
                          "Marcha",
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
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('pacientes')
                      .doc(parameterValue)
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(parameterValue);
                    if (snapshot.hasData) {
                      final paciente = snapshot.data;

                      final taskAudio = paciente?['taskaudio'];
                      final taskMarcha = paciente?['taskmarcha'];
                      final dualTask = paciente?['dualtask'];

                      
                      if (taskMarcha == true) {
                        isTaskMarchaEnabled = false;
                        print("llego");
                      }

                      return ElevatedButton(
                        onPressed: isTaskMarchaEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/taskMarcha",
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
                          "Brazos",
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
                    onPressed: isTaskDualTaskEnabled
                        ? () {
                            Navigator.of(context).pushNamed(
                              "/listPatient",
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
                      "Salir",
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
