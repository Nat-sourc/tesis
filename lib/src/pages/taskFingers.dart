import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/components/cameraScreen.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:flutter_gif/flutter_gif.dart';

class TaskFingers extends StatefulWidget {
  const TaskFingers({Key? key}) : super(key: key);

  @override
  State<TaskFingers> createState() => _TaskFingersState();
}

class _TaskFingersState extends State<TaskFingers> with TickerProviderStateMixin {
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
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/dedos.jpeg",
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
                     "Golpeteo de dedos, con la mano derecha",
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
                     "Toque el índice con el pulgar 10 veces tan rápida y ampliamente como sea posible.",
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
                      '/taskFingersIzq',
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
                      '/cameraFingers',
                      arguments: parameterValue,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: const Size(140, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Comencemos",
                    style: TextStyle(
                      fontFamily: 'RobotoMono-Bold',
                      fontSize: 16,
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