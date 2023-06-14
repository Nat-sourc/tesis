import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraHand extends StatefulWidget {
  const CameraHand({super.key});

  @override
  State<CameraHand> createState() => _CameraHandState();
}

class _CameraHandState extends State<CameraHand> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "pronosup";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoHand',arguments: parameterValue);
      },
    );
  }
}
