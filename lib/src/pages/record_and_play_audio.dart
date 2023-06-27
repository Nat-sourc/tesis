import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:brainFit/src/providers/play_audio_provider.dart';
import 'package:brainFit/src/providers/record_audio_provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class RecordAndPlayScreen extends StatefulWidget {
  final String? parameterValue;
  const RecordAndPlayScreen({required this.parameterValue, Key? key})
      : super(key: key);

  @override
  State<RecordAndPlayScreen> createState() => _RecordAndPlayScreenState();
}

class _RecordAndPlayScreenState extends State<RecordAndPlayScreen> {
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.pexels.com/photos/1785493/pexels-photo-1785493.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=200"))),
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
              _nextButton(),
          ],
        ),
      ),
    );
  }

  _recordHeading() {
    return const Center(
      child: Text(
        'Desde 100 haga la resta de 3 en 3',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
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
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
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
          color: Color.fromARGB(255, 48, 178, 221),
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
        color: Color.fromARGB(255, 37, 230, 248),
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
      color: Color.fromARGB(255, 43, 185, 220),
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
        progressColor: Color.fromARGB(255, 62, 183, 231),
      ),
    ));
  }

  _nextButton() {
    return InkWell(
      child: ElevatedButton(
        onPressed: () {
          updateTaskAudio();
          Navigator.pushNamed(context, '/buttonsTasks',
            arguments: widget.parameterValue);
          }, // Asigna una función aquí
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
          .update({'taskaudio': true});
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
            color: Color.fromARGB(255, 75, 121, 201),
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
