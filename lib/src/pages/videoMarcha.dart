import 'package:flutter/material.dart';
import '../components/videoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoMarcha extends StatefulWidget {
  const VideoMarcha({Key? key}) : super(key: key);

  @override
  State<VideoMarcha> createState() => _VideoMarchaState();
}

class _VideoMarchaState extends State<VideoMarcha> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;

    return VideoApp(
      navegate: () async {
        await updateTaskMarcha(parameterValue);
        Navigator.pushNamed(context, '/buttonsTasks', arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraMarcha', arguments: parameterValue);
      },
    );
  }

  Future<void> updateTaskMarcha(String? parameterValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(parameterValue)
          .update({'taskmarcha': true});
      print('Task Marcha updated successfully');
    } catch (error) {
      print('Error updating Task Marcha: $error');
    }
  }
}
