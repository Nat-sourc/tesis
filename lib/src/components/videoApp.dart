import 'dart:io';

import 'package:brainFit/src/components/titleImg.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final VoidCallback? navegate;
  final VoidCallback? navegateNew;

  const VideoApp({Key? key, this.navegate, this.navegateNew}) : super(key: key);

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    String lastVideoPath = await getLastVideo();
    if (lastVideoPath.isNotEmpty) {
      _controller = VideoPlayerController.file(File(lastVideoPath))
        ..initialize().then((_) {
          setState(() {});
        });
    }
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
                  deleteLastVideo();
                  widget.navegateNew!();
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
                  widget.navegate!();
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
    String lastVideoPath = "";
    ArchivoRepo archivoRepo = ArchivoRepo();
    List<ArchivoDB> lista = await archivoRepo.getAll();
    if (lista.isNotEmpty) {
      lastVideoPath = lista.last.path.toString();
    }
    return lastVideoPath;
  }

  Future<void> deleteLastVideo() async {
    String lastVideoPath = await getLastVideo();
    if (lastVideoPath.isNotEmpty) {
      try {
        File lastVideoFile = File(lastVideoPath);
        await lastVideoFile.delete();
        print("llege");
        // Elimina la entrada de la base de datos
        ArchivoRepo archivoRepo = ArchivoRepo();
        List<ArchivoDB> lista = await archivoRepo.getAll();
        if (lista.isNotEmpty) {
          await archivoRepo.delete(
              lista.last); // Pasamos el objeto ArchivoDB en lugar de un entero
        }
      } catch (e) {
        print("Error al eliminar el último video: $e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
