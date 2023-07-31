import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraDualTaskArm extends StatefulWidget {
  const CameraDualTaskArm({super.key});

  @override
  State<CameraDualTaskArm> createState() => _CameraDualTaskArmState();
}

class _CameraDualTaskArmState extends State<CameraDualTaskArm> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "DUALdualArmTask";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoDualArm', arguments: parameterValue);
      },
    );
  }
}