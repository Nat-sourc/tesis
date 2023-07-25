import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoHandIzq extends StatefulWidget {
  const VideoHandIzq({Key? key}) : super(key: key);

  @override
  State<VideoHandIzq> createState() => _VideoHandIzqState();
}

class _VideoHandIzqState extends State<VideoHandIzq> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;

    // Actualizar el valor en Firebase
    void updateFirebaseValue() async {
      if (parameterValue != null) {
        final CollectionReference patientsCollection = FirebaseFirestore.instance.collection('pacientes');
        final DocumentReference patientDocument = patientsCollection.doc(parameterValue);

        try {
          await patientDocument.update({'completeTaskBradicinesis': true});
          print('Valor actualizado en Firebase');
        } catch (error) {
          print('Error al actualizar el valor en Firebase: $error');
        }
      }
    }

    return VideoApp(
      navegate: () {
        // Llamar a la función para actualizar el valor en Firebase
        updateFirebaseValue();
        // Realizar la navegación
        Navigator.pushNamed(context, '/buttonBradicinesis', arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraHandIzq', arguments: parameterValue);
      },
    );
  }
}
