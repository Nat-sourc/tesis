import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/videoApp.dart';

class VideoBradicinesiaIzq extends StatefulWidget {
  const VideoBradicinesiaIzq({super.key});

  @override
  State<VideoBradicinesiaIzq> createState() => _VideoBradicinesiaState();
}

class _VideoBradicinesiaState extends State<VideoBradicinesiaIzq> {
  @override
  Widget build(BuildContext context) {
    
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return VideoApp(
      navegate: () {
        Navigator.pushNamed(context, '/taskFingers',arguments: parameterValue);
      },
      navegateNew: () {
        Navigator.pushNamed(context, '/cameraBradicinesiaIzq',arguments: parameterValue);
      },
    );
  }

}