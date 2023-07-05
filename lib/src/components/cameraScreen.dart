import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreen> {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    iniciarCamara();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_widgetState) {
      case WidgetState.NONE:
      case WidgetState.LOADING:
        return _buildScafoold(
          context,
          const Center(child: CircularProgressIndicator()),
        );
      case WidgetState.LOADED:
        return _buildScafoold(
          context,
          CameraPreview(_cameraController),
        );
      case WidgetState.ERROR:
        return _buildScafoold(
          context,
          const Center(
              child: Text(
                  "Problemnas con la camara; por favor reinicia la aplicación")),
        );
    }
  }

  Widget _buildScafoold(BuildContext context, body) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotografia'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            XFile xfile = await _cameraController.takePicture();
            Navigator.pop(context, xfile.path);
          },
          child: const Icon(
            Icons.camera,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future iniciarCamara() async {
    _widgetState = WidgetState.LOADING;
    if (mounted) setState(() {});
    await availableCameras().then((value) => _cameras = value);
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.low,
    );

    await _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.ERROR;
      if (mounted) setState(() {});
    } else {
      _widgetState = WidgetState.LOADED;
    }
  }
}