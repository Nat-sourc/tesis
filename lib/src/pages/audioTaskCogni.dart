import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainFit/src/providers/play_audio_provider.dart';
import 'package:brainFit/src/providers/record_audio_provider.dart';
import 'package:brainFit/src/pages/record_and_play_audioCogni.dart';

class AudioTaskCogni extends StatefulWidget {
  const AudioTaskCogni({Key? key}) : super(key: key);

  @override
  _AudioTaskCogniState createState() => _AudioTaskCogniState();
}

class _AudioTaskCogniState extends State<AudioTaskCogni> {
  late RecordAudioProvider recordAudioProvider;
  late PlayAudioProvider playAudioProvider;

  @override
  void initState() {
    super.initState();
    recordAudioProvider = RecordAudioProvider();
    playAudioProvider = PlayAudioProvider();
  }

  @override
  void dispose() {
    recordAudioProvider.dispose();
    playAudioProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? parameterValue =
        ModalRoute.of(context)?.settings.arguments as String?;
    return ChangeNotifierProvider.value(
      value: recordAudioProvider,
      child: ChangeNotifierProvider.value(
        value: playAudioProvider,
        child: RecordAndPlayScreenCogni(parameterValue: parameterValue),
      ),
    );
  }
}

// Otras clases de páginas y componentes ...
