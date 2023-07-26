import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoFingersIzq extends StatefulWidget {
  const VideoFingersIzq({super.key});

  @override
  State<VideoFingersIzq> createState() => _VideoFingersIzqState();
}

class _VideoFingersIzqState extends State<VideoFingersIzq> {
  @override
  Widget build(BuildContext context) {
    
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return VideoApp(
      navegate: () {
        Navigator.pushNamed(context, '/taskHand',arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraFingersIzq',arguments: parameterValue);
      },
    );
  }
}