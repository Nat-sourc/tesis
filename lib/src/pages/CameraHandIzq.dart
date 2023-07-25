import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraHandIzq extends StatefulWidget {
  const CameraHandIzq({super.key});

  @override
  State<CameraHandIzq> createState() => _CameraHandIzqState();
}

class _CameraHandIzqState extends State<CameraHandIzq> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "pronosupIzquierda";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoHandIzq',arguments: parameterValue);
      },
    );
  }
}
