import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:brainFit/src/services/permission_management.dart';
import 'package:brainFit/src/services/storage_management.dart';
import 'package:brainFit/src/services/toast_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class RecordAudioProvider extends ChangeNotifier {
  final Record _record = Record();
  bool _isRecording = false;
  String _afterRecordingFilePath = '';

  bool get isRecording => _isRecording;
  String get recordedFilePath => _afterRecordingFilePath;

  clearOldData() {
    _afterRecordingFilePath = '';
    notifyListeners();
  }

  recordVoice() async {
    final _isPermitted = (await PermissionManagement.recordingPermission()) &&
        (await PermissionManagement.storagePermission());

    if (!_isPermitted) return;

    if (!(await _record.hasPermission())) return;

    final _voiceDirPath = await StorageManagement.getAudioDir;
    final _voiceFilePath = StorageManagement.createRecordAudioPath(
        dirPath: _voiceDirPath, fileName: 'DUAL');

    await _record.start(path: _voiceFilePath);
    _isRecording = true;
    notifyListeners();

    showToast('Inicio grabación');
  }

  stopRecording(String parameterValue) async {
    String? _audioFilePath;

    if (await _record.isRecording()) {
      _audioFilePath = await _record.stop();
      showToast('Grabación parada');
    }

    print('Audio file path: $_audioFilePath');

    _isRecording = false;
    _afterRecordingFilePath = _audioFilePath ?? '';
    String? path = _audioFilePath;
    guardarRegistro(path!, parameterValue);
    notifyListeners();
  }

  stopRecordingCogni(String parameterValue) async {
    String? _audioFilePath;

    if (await _record.isRecording()) {
      _audioFilePath = await _record.stop();
      showToast('Grabación parada');
    }

    print('Audio file path: $_audioFilePath');

    _isRecording = false;
    _afterRecordingFilePath = _audioFilePath ?? '';

    // Añadir "Cogni" al nombre del archivo
    String? fileName = _audioFilePath?.split('/').last;
    String? directoryPath = _audioFilePath?.replaceAll('/$fileName', '');
    String? modifiedFileName = 'Cogni_$fileName';
    String? modifiedFilePath = '$directoryPath/$modifiedFileName';

    // Renombrar el archivo de audio
    if (_audioFilePath != null) {
      await File(_audioFilePath).rename(modifiedFilePath);
      _audioFilePath = modifiedFilePath;
    }

    String? path = _audioFilePath;
    guardarRegistroCogni(path!, parameterValue);
    notifyListeners();
  }

  Future<void> guardarRegistroCogni(
      String nameFile, String parameterValue) async {
    nameFile = nameFile;
    ArchivoRepo archivoRepo = ArchivoRepo();
    // Obtener la fecha y hora actual
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    ArchivoDB archivo = ArchivoDB(
        idPaciente: parameterValue,
        idDoctor: 0,
        path: nameFile,
        fecha: formattedDate,
        estado: 0);
    int id = await archivoRepo.insert(archivo);
    print("IDENTIFICADOR: " + id.toString());
    return;
  }

  Future<void> guardarRegistro(String nameFile, String parameterValue) async {
    ArchivoRepo archivoRepo = ArchivoRepo();
    // Obtener la fecha y hora actual
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    ArchivoDB archivo = ArchivoDB(
        idPaciente: parameterValue,
        idDoctor: 0,
        path: nameFile,
        fecha: formattedDate,
        estado: 0);
    int id = await archivoRepo.insert(archivo);
    print("IDENTIFICADOR: " + id.toString());
    return;
  }
}
