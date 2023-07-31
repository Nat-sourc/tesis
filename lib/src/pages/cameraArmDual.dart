import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraArm extends StatefulWidget {
  const CameraArm({super.key});

  @override
  State<CameraArm> createState() => _CameraArmState();
}

class _CameraArmState extends State<CameraArm> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "DUALBrazo";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/VideoArm', arguments: parameterValue);
      },
    );
  }
}
