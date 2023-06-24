import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraMarcha extends StatefulWidget {
  const CameraMarcha({super.key});

  @override
  State<CameraMarcha> createState() => _CameraMarchaState();
}

class _CameraMarchaState extends State<CameraMarcha> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "DUALmarcha";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoMarcha', arguments: parameterValue);
      },
    );
  }
}
