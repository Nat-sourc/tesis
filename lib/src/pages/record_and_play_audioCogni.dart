import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:brainFit/src/providers/play_audio_provider.dart';
import 'package:brainFit/src/providers/record_audio_provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class RecordAndPlayScreenCogni extends StatefulWidget {
  final String? parameterValue;
  const RecordAndPlayScreenCogni({required this.parameterValue, Key? key})
      : super(key: key);

  @override
  State<RecordAndPlayScreenCogni> createState() =>
      _RecordAndPlayScreenCogniState();
}

class _RecordAndPlayScreenCogniState extends State<RecordAndPlayScreenCogni> {
  customizeStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
  }

  @override
  void initState() {
    customizeStatusAndNavigationBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            _recordProvider.recordedFilePath.isEmpty
                ? _recordHeading()
                : _playAudioHeading(),
            //const SizedBox(height: 80),
            //  _playTime(),
            const SizedBox(height: 40),
            _recordProvider.recordedFilePath.isEmpty
                ? _recordingSection()
                : _audioPlayingSection(),
            if (_recordProvider.recordedFilePath.isNotEmpty &&
                !_playProvider.isSongPlaying)
              const SizedBox(height: 40),
            if (_recordProvider.recordedFilePath.isNotEmpty &&
                !_playProvider.isSongPlaying)
              _resetButton(),
            if (_recordProvider.recordedFilePath.isNotEmpty &&
                !_playProvider.isSongPlaying)
              const SizedBox(height: 40),
            if (_recordProvider.recordedFilePath.isNotEmpty &&
                !_playProvider.isSongPlaying)
              //_nextButton(),
              ElevatedButton(
                onPressed: () {
                  updateTaskAudio();
                  Navigator.of(context).pushNamed("/ButtonCognitivas",
                      arguments: widget.parameterValue);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                  minimumSize: const Size(350, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Siguiente",
                  style: TextStyle(
                    fontFamily: 'RobotoMono-Bold',
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _recordHeading() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Prueba audio F.V',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'RobotoMono-Bold',
              fontSize: 30,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _indicaciones(), // Llamada a la función _indicaciones()
      ],
    );
  }

  _indicaciones() {
    return const Center(
      child: Text(
        "Acerque el mircrofono al paciente, al oprimir el botón grabe la respuesta de: Palabras que inicien por la letra A",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'RobotoMono-Bold',
          fontSize: 18,
        ),
      ),
    );
  }

  _playTime() {
    final duration = Duration.zero;
    return Text('${duration.inSeconds} s');
  }

  _playAudioHeading() {
    return const Center(
      child: Text(
        'Audio grabado',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'RobotoMono-Bold',
            color: Color.fromARGB(255, 1, 1, 1)),
      ),
    );
  }

  _recordingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _recordProviderWithoutListener =
        Provider.of<RecordAudioProvider>(context, listen: false);

    if (_recordProvider.isRecording) {
      return InkWell(
        onTap: () async => await _recordProviderWithoutListener
            .stopRecording(widget.parameterValue!),
        child: RippleAnimation(
          repeat: true,
          color: Color.fromARGB(255, 0, 191, 166),
          minRadius: 40,
          ripplesCount: 6,
          child: _commonIconSection(),
        ),
      );
    }

    return InkWell(
      onTap: () async => await _recordProviderWithoutListener.recordVoice(),
      child: _commonIconSection(),
    );
  }

  _commonIconSection() {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 191, 166),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(Icons.keyboard_voice_rounded,
          color: Colors.white, size: 30),
    );
  }

  _audioPlayingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _audioControllingSection(_recordProvider.recordedFilePath),
          _audioProgressSection(),
        ],
      ),
    );
  }

  _audioControllingSection(String songPath) {
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    final _playProviderWithoutListen =
        Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;

        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(
          _playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded),
      color: Color.fromARGB(255, 0, 191, 166),
      iconSize: 30,
    );
  }

  _audioProgressSection() {
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Expanded(
        child: Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: LinearPercentIndicator(
        percent: _playProvider.currLoadingStatus,
        backgroundColor: Colors.black26,
        progressColor: Color.fromARGB(255, 0, 191, 166),
      ),
    ));
  }

  _nextButton() {
    return InkWell(
      child: ElevatedButton(
        onPressed: () {
          updateTaskAudio();
          Navigator.pushNamed(context, '/ButtonCognitivas',
              arguments: widget.parameterValue);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 191, 166),
          minimumSize: const Size(50, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Seguir",
          style: TextStyle(fontFamily: 'RobotoMono-Bold', fontSize: 12),
        ),
      ),
    );
  }

  Future<void> updateTaskAudio() async {
    try {
      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(widget.parameterValue)
          .update({'taskaudioCogni': true});
      print('Task Audio updated successfully');
    } catch (error) {
      print('Error updating Task Marcha: $error');
    }
  }

  _resetButton() {
    final _recordProvider =
        Provider.of<RecordAudioProvider>(context, listen: false);

    return InkWell(
      onTap: () => _recordProvider.clearOldData(),
      child: Center(
        child: Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 191, 166),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Repetir',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
