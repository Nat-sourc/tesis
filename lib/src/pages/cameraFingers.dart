import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraFingers extends StatefulWidget {
  const CameraFingers({super.key});

  @override
  State<CameraFingers> createState() => _CameraFingersState();
}

class _CameraFingersState extends State<CameraFingers> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "fingertap";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoFingers',arguments: parameterValue);
      },
    );
  }
}