import 'package:flutter/material.dart';

import '../components/cameraComponent.dart';

class CameraDualTask extends StatefulWidget {
  const CameraDualTask({super.key});

  @override
  State<CameraDualTask> createState() => _CameraDualTaskState();
}

class _CameraDualTaskState extends State<CameraDualTask> {
  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    final String name = "DUALdualTask";
    return CameraComponent(
      parameterValue: parameterValue,
      nameTask: name,
      onStopButtonPressed: () {
        Navigator.pushNamed(context, '/videoDual', arguments: parameterValue);
      },
    );
  }
}
