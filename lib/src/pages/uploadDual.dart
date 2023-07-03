import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:archive/archive_io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path_provider;

class UploadVideoDual extends StatefulWidget {
  const UploadVideoDual({Key? key}) : super(key: key);

  @override
  _UploadVideoDualState createState() => _UploadVideoDualState();
}

class _UploadVideoDualState extends State<UploadVideoDual> {
  List<String> videoPaths = []; // List of selected video paths
  List<String> imagePaths = []; // List of selected image paths
  late String idPatient; // ID of the patient
  double uploadProgress = 0.0; // Upload progress

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      List<ArchivoDB> videoArchivos = await getListVideos([idPatient]);
      videoPaths = videoArchivos
          .map((archivo) => archivo.path)
          .whereType<String>()
          .toList();

      List<ArchivoDB> imageArchivos = await getListImages([idPatient]);
      imagePaths = imageArchivos
          .map((archivo) => archivo.path)
          .whereType<String>()
          .toList();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    idPatient = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100.0,
            ),
            const Text(
              "Subir Videos y Audio",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'RobotoMono-Bold',
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 150, maxHeight: 150),
                  child: Image.asset(
                    "assets/img/upload.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: saveVideosAndImagesAsZip,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                minimumSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Subir videos e imágenes del Paciente: $idPatient',
                style: TextStyle(
                  fontFamily: 'RobotoMono-Bold',
                  fontSize: 13,
                ),
              ),
            ),
            if (uploadProgress > 0.0 && uploadProgress < 1.0)
              LinearProgressIndicator(value: uploadProgress),
          ],
        ),
      ),
    );
  }

  Future<List<ArchivoDB>> getListVideos(List<String> patientIds) async {
    ArchivoRepo archivoRepo = ArchivoRepo();
    List<ArchivoDB> lista = await archivoRepo.getAll();

    List<ArchivoDB> filteredList =
        lista.where((archivo) => patientIds.contains(archivo.idPaciente)).toList();

    return filteredList;
  }

  Future<List<ArchivoDB>> getListImages(List<String> patientIds) async {
    ArchivoRepo archivoRepo = ArchivoRepo();
    List<ArchivoDB> lista = await archivoRepo.getAll();

    List<ArchivoDB> filteredList =
        lista.where((archivo) => patientIds.contains(archivo.idPaciente)).toList();

    return filteredList;
  }

  Future<void> saveVideosAndImagesAsZip() async {
    if (videoPaths.isEmpty && imagePaths.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No videos or images selected.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    Archive archive = Archive();

    // Add videos to the archive
    for (int i = 0; i < videoPaths.length; i++) {
      String videoPath = videoPaths[i];
      String videoName = path_provider.basename(videoPath);

      // Check if the video name contains "DUAL"
      if (videoName.contains("DUAL")) {
        File videoFile = File(videoPath);

        List<int> videoBytes = await videoFile.readAsBytes();
        ArchiveFile archiveFile = ArchiveFile(videoName, videoBytes.length, videoBytes);

        archive.addFile(archiveFile);
      }
    }

    // Add images to the archive
    for (int i = 0; i < imagePaths.length; i++) {
      String imagePath = imagePaths[i];
      String imageName = path_provider.basename(imagePath);

      // Check if the image name contains "DUAL"
      if (imageName.contains("DUAL")) {
        File imageFile = File(imagePath);

        List<int> imageBytes = await imageFile.readAsBytes();
        ArchiveFile archiveFile = ArchiveFile(imageName, imageBytes.length, imageBytes);

        archive.addFile(archiveFile);
      }
    }

    Directory? tempDirectory = await getTemporaryDirectory();
    if (tempDirectory != null) {
      String zipPath = path_provider.join(tempDirectory.path, 'dualTask.zip');
      File zipFile = File(zipPath);
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }
      zipFile.writeAsBytesSync(ZipEncoder().encode(archive) as List<int>);

      // Upload ZIP file to Firebase Storage
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$idPatient/dualTask.zip');
      firebase_storage.UploadTask uploadTask = storageRef.putFile(zipFile);

      uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cargando Videos e Imagenes'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(value: progress / 100),
                  const SizedBox(height: 16.0),
                  Text('Cargando... ${progress.toStringAsFixed(2)}%'),
                ],
              ),
            );
          },
        );
      });

      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('pacientes')
          .doc(idPatient)
          .update({'completetask': true});

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Text('Los Videos e Imágenes Se Han Subido Correctamente'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/principalPage",
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
