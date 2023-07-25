import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoHand extends StatefulWidget {
  const VideoHand({super.key});

  @override
  State<VideoHand> createState() => _VideoHandState();
}

class _VideoHandState extends State<VideoHand> {
  @override
  Widget build(BuildContext context) {
    
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return VideoApp(
      navegate: () {
        Navigator.pushNamed(context, '/taskHandIzq',arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraHand',arguments: parameterValue);
      },
    );
  }
}