import 'package:flutter/material.dart';
import '../components/titleImg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonTaskDualTask extends StatefulWidget {
  const ButtonTaskDualTask({Key? key}) : super(key: key);

  @override
  State<ButtonTaskDualTask> createState() => _ButtonTaskDualTaskState();
}

class _ButtonTaskDualTaskState extends State<ButtonTaskDualTask> {
  bool isTaskAudioEnabled = true;
  bool isTaskSimplesMotorasEnabled = true;
  bool isTaskMarchaEnabled = true;
  bool isTaskDualTaskEnabled = true;
  bool isTaskDualvTaskEnabled = true;

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
                      final taskAudioCogni = paciente?['taskaudioCogni'];

                      if (taskAudio == true && taskAudioCogni == true) {
                        isTaskAudioEnabled = false;
                        print("no llego");
                      }

                      return ElevatedButton(
                        onPressed: isTaskAudioEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/ButtonCognitivas",
                                  //"/audioTask",
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
                          "Tareas Simples Cognitivas",
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

                      final taskArm = paciente?['taskArm'];
                      final taskMarcha = paciente?['taskmarcha'];

                      
                      if (taskMarcha == true && taskArm == true) {
                        isTaskSimplesMotorasEnabled = false;
                      }
                      return ElevatedButton(
                        onPressed: isTaskSimplesMotorasEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/ButtonMotoras",
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
                          "Simples Motoras",
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

                      final taskArm = paciente?['taskArmDual'];
                      final taskMarcha = paciente?['taskmarchaDual'];


                      if (taskArm == true && taskMarcha == true) {
                        isTaskDualvTaskEnabled = false;
                        print("no llego");
                      }

                      return ElevatedButton(
                        onPressed: isTaskDualvTaskEnabled
                            ? () {
                                Navigator.of(context).pushNamed(
                                  "/ButtonDual",
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
                          "Dual-Task",
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
                              "/uploadDual",
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
