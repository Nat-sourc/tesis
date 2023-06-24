import 'package:flutter/material.dart';
import '../components/videoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDualTask extends StatefulWidget {
  const VideoDualTask({Key? key}) : super(key: key);

  @override
  State<VideoDualTask> createState() => _VideoDualTaskState();
}

class _VideoDualTaskState extends State<VideoDualTask> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;

    return VideoApp(
      navegate: () async {
        await updateTaskMarcha(parameterValue);
        Navigator.pushNamed(context, '/buttonsTasks', arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraDual', arguments: parameterValue);
      },
    );
  }

  Future<void> updateTaskMarcha(String? parameterValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(parameterValue)
          .update({'dualtask': true});
      print('Task Marcha updated successfully');
    } catch (error) {
      print('Error updating Task Marcha: $error');
    }
  }
}
