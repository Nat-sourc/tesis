import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraBradicinesiaIzq extends StatefulWidget {
  const CameraBradicinesiaIzq({Key? key}) : super(key: key);

  @override
  State<CameraBradicinesiaIzq> createState() => _CameraBradicinesiaState();
}

class _CameraBradicinesiaState extends State<CameraBradicinesiaIzq> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "fistIzquierda";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoBradicinesiaIzq', arguments: parameterValue);
      },
    );
  }
}
