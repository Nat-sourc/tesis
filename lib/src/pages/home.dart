import 'package:flutter/material.dart';
import 'package:nombre_del_proyecto/src/components/titleImg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {showPantallaBradicinesia("/taskFist")},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: const Size(350, 50),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text("Comencemos",
                      style: TextStyle(
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 20)), 
                )
              ],
            ),
          ])),
    );
  }
  void showPantallaBradicinesia(String ruta) {
    Navigator.of(context).pushNamed(ruta);
}
}


