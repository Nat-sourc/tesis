import 'package:flutter/material.dart';
import '../components/videoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDualTaskArm extends StatefulWidget {
  const VideoDualTaskArm({Key? key}) : super(key: key);

  @override
  State<VideoDualTaskArm> createState() => _VideoDualTaskArmState();
}

class _VideoDualTaskArmState extends State<VideoDualTaskArm> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;

    return VideoApp(
      navegate: () async {
        await updateTaskMarcha(parameterValue);
        Navigator.pushNamed(context, '/ButtonDual', arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraDualArm', arguments: parameterValue);
      },
    );
  }

  Future<void> updateTaskMarcha(String? parameterValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(parameterValue)
          .update({'taskArmDual': true});
      print('Task Marcha updated successfully');
    } catch (error) {
      print('Error updating Task Marcha: $error');
    }
  }
}
