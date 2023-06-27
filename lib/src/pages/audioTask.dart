
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainFit/src/providers/play_audio_provider.dart';
import 'package:brainFit/src/providers/record_audio_provider.dart';
import 'package:brainFit/src/pages/record_and_play_audio.dart';


class AudioTask extends StatelessWidget {
  const AudioTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? parameterValue = ModalRoute.of(context)?.settings.arguments as String?;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grabadora de voz',
        home: RecordAndPlayScreen(parameterValue: parameterValue),
      ),
    );
  }
}
 