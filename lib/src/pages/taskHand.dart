import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/components/cameraScreen.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:flutter_gif/flutter_gif.dart';

class TaskHand extends StatefulWidget {
  const TaskHand({Key? key}) : super(key: key);

  @override
  State<TaskHand> createState() => _TaskHandState();
}

class _TaskHandState extends State<TaskHand> with TickerProviderStateMixin {
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
            
            AspectRatio(
              aspectRatio: 1.0, // Mantener una proporción cuadrada
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Establecer el color de fondo como transparente
                ),
                child: GifImage(
                  controller: controller1,
                  image: AssetImage('assets/img/video3.gif'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Movimiento de supinación de las manos",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'RobotoMono-Bold',
                    fontSize: 20,
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
                    "Posicione el brazo como se muestra en el video, gire la palma de la mano hacia atrás y adelante alternativamente 10 veces, tan rápido y completamente como sea posible",
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
            ElevatedButton(
              onPressed: () async {
                //await iniciarCamara();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamed(
                  '/cameraHand',
                  arguments: parameterValue,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                minimumSize: const Size(350, 50),
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
      ),
    );
  }
}
