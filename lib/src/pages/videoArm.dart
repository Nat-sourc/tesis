import 'package:flutter/material.dart';
import '../components/videoApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoArm extends StatefulWidget {
  const VideoArm({Key? key}) : super(key: key);

  @override
  State<VideoArm> createState() => _VideoArmState();
}

class _VideoArmState extends State<VideoArm> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;

    return VideoApp(
      navegate: () async {
        await updateTaskMarcha(parameterValue);
        Navigator.pushNamed(context, '/ButtonMotoras', arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/CameraArm', arguments: parameterValue);
      },
    );
  }

  Future<void> updateTaskMarcha(String? parameterValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(parameterValue)
          .update({'taskArm': true});
      print('Task Arm updated successfully');
    } catch (error) {
      print('Error updating Task Arm: $error');
    }
  }
}
