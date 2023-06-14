import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoBradicinesia extends StatefulWidget {
  const VideoBradicinesia({super.key});

  @override
  State<VideoBradicinesia> createState() => _VideoBradicinesiaState();
}

class _VideoBradicinesiaState extends State<VideoBradicinesia> {
  @override
  Widget build(BuildContext context) {
    
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return VideoApp(
      navegate: () {
        Navigator.pushNamed(context, '/taskFingers',arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraBradicinesia',arguments: parameterValue);
      },
    );
  }

}