import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraBradicinesia extends StatefulWidget {
  const CameraBradicinesia({Key? key}) : super(key: key);

  @override
  State<CameraBradicinesia> createState() => _CameraBradicinesiaState();
}

class _CameraBradicinesiaState extends State<CameraBradicinesia> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "first";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoBradicinesia', arguments: parameterValue);
      },
    );
  }
}
