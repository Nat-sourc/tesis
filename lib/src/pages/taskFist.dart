import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/components/cameraScreen.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:flutter_gif/flutter_gif.dart';

class TaskFist extends StatefulWidget {
  const TaskFist({Key? key}) : super(key: key);

  @override
  State<TaskFist> createState() => _TaskFistState();
}

class _TaskFistState extends State<TaskFist> with TickerProviderStateMixin {
  late FlutterGifController controller1;

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 130,
        period: const Duration(milliseconds: 3000),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            const TitleImg(),
            /*AspectRatio(
              aspectRatio: 1.0, // Mantener una proporción cuadrada
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Establecer el color de fondo como transparente
                ),
                child: GifImage(
                  controller: controller1,
                  image: AssetImage('assets/img/video1.gif'),
                  fit: BoxFit.contain,
                ),
              ),
            ),*/
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/fistPrueba.jpeg",
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Movimiento con las manos, mano derecha",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RobotoMono-Bold',
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Posicionar el brazo de la manera en que se muestra el video, abra y cierre la mano 10 veces tan rápida y completamente como le sea posible",
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
            const SizedBox(
              height: 50.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/taskFistIzq',
                      arguments: parameterValue,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: const Size(180, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Saltar Prueba",
                    style: TextStyle(
                      fontFamily: 'RobotoMono-Bold',
                      fontSize: 16,
                      color: Colors.white, // Cambia el color del texto según tus preferencias
                    ),
                  ),
                ),
                SizedBox(width: 20), // Espacio entre el botón adicional y "Comencemos"
                ElevatedButton(
                  onPressed: () async {
                    //await iniciarCamara();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed(
                      '/cameraBradicinesia',
                      arguments: parameterValue,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: const Size(180, 50),
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
          ],
        ),
      ),
    );
  }
}
