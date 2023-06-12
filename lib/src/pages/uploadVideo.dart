import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path_provider;

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  List<String> videoPaths = []; // List of selected video paths
  late String idPatient; // ID of the patient

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      List<ArchivoDB> archivos = await getListVideos([idPatient]);
      videoPaths = archivos.map((archivo) => archivo.path).whereType<String>().toList();
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
              "Subir Videos",
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
                  constraints: BoxConstraints(maxWidth: 150, maxHeight: 150), // Tamaño máximo de la imagen
                  child: Image.asset(
                    "assets/img/upload.png",
                    fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: saveVideosAsZip,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                minimumSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Subir videos Paciente: $idPatient',
                style: TextStyle(
                  fontFamily: 'RobotoMono-Bold',
                  fontSize: 13,
                ),
              ),
            ),
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

  Future<void> saveVideosAsZip() async {
    if (videoPaths.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No videos selected.'),
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

    for (int i = 0; i < videoPaths.length; i++) {
      String videoPath = videoPaths[i];
      String videoName = path_provider.basename(videoPath);

      File videoFile = File(videoPath);

      List<int> videoBytes = await videoFile.readAsBytes();
      ArchiveFile archiveFile = ArchiveFile(videoName, videoBytes.length, videoBytes);

      archive.addFile(archiveFile);
    }

    Directory? appDocumentsDirectory = await getApplicationDocumentsDirectory();
    if (appDocumentsDirectory != null) {
      String zipPath = path_provider.join(appDocumentsDirectory.path, 'bradicinesia.zip');
      File zipFile = File(zipPath);
      if (zipFile.existsSync()) {
        zipFile.deleteSync();
      }
      zipFile.writeAsBytesSync(ZipEncoder().encode(archive) as List<int>);

      // Upload ZIP file to Firebase Storage
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$idPatient/bradicinesia.zip'); // Use the ID of the patient in the storage path
      firebase_storage.UploadTask uploadTask = storageRef.putFile(zipFile);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Text('Los Videos Se Han Subido Correctamente'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      "/principalPage"
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
