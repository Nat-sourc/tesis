import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraFingersIzq extends StatefulWidget {
  const CameraFingersIzq({super.key});

  @override
  State<CameraFingersIzq> createState() => _CameraFingersIzqState();
}

class _CameraFingersIzqState extends State<CameraFingersIzq> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "fingertapIzquierda";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoFingersIzq',arguments: parameterValue);
      },
    );
  }
}