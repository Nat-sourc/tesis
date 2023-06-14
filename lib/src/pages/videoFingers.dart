import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoFingers extends StatefulWidget {
  const VideoFingers({super.key});

  @override
  State<VideoFingers> createState() => _VideoFingersState();
}

class _VideoFingersState extends State<VideoFingers> {
  @override
  Widget build(BuildContext context) {
    
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return VideoApp(
      navegate: () {
        Navigator.pushNamed(context, '/taskHand',arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraFingers',arguments: parameterValue);
      },
    );
  }
}