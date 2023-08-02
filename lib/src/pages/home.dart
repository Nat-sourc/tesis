import 'package:flutter/material.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:brainFit/src/dbsqlite/DBLocalBrainFit.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ArchivoRepo archivoRepo;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
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
                        height: 80.0,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/doctors.png",
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
                      Text("Control app",
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
                            "Aplicación para apoyo médico en el momento de Dual task",
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
                    onPressed: () => {showPantallaBradicinesia("/login")},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text("Comencemos",
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Bold', fontSize: 20)),
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
                    onPressed: () => {
                      DBLocalBrainFit.openDBWithCreateTables(),
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text("Iniciar DB",
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Bold', fontSize: 20)),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                        height: 50.0,
                      )
                    ],
                  ),
                ])),
          ],
        ));
  }

  void showPantallaBradicinesia(String ruta) {
    Navigator.of(context).pushNamed(ruta);
  }
}
