import 'dart:io';

import 'package:brainFit/src/components/titleImg.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    final File file = File("");
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String name = await getLastVideo();
      final File file = File(name);
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video brainFit',
      home: Scaffold(
        body: ListView(padding: const EdgeInsets.all(10), children: [
          const SizedBox(
            width: 30.0,
            height: 40.0,
          ),
          const TitleImg(),
          const SizedBox(
            width: 30.0,
            height: 40.0,
          ),
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          const SizedBox(
            width: 30.0,
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  //await iniciarCamara();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed('/camera');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Nuevo",
                    style:
                        TextStyle(fontFamily: 'RobotoMono-Bold', fontSize: 12)),
              ),
              const SizedBox(
                width: 10.0,
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  //await iniciarCamara();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed('/taskFingers');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Seguir",
                    style:
                        TextStyle(fontFamily: 'RobotoMono-Bold', fontSize: 12)),
              ),
            ],
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 191, 166),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  Future<String> getLastVideo() async {
    String nameUltimoVideo = "";
    ArchivoRepo archivoRepo = ArchivoRepo();
    List<ArchivoDB> lista = await archivoRepo.getAll();
    nameUltimoVideo = lista.last.path.toString();
    return nameUltimoVideo;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
