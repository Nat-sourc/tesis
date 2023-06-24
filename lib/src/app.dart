import 'package:brainFit/src/components/videoApp.dart';
import 'package:brainFit/src/pages/button_Task.dart';
import 'package:brainFit/src/pages/cameraBradicinesia.dart';
import 'package:brainFit/src/pages/cameraDualTask.dart';
import 'package:brainFit/src/pages/cameraFingers.dart';
import 'package:brainFit/src/pages/cameraHand.dart';
import 'package:brainFit/src/pages/cameraMarcha.dart';
import 'package:brainFit/src/pages/createPatient.dart';
import 'package:brainFit/src/pages/listVideos.dart';
import 'package:brainFit/src/pages/taskDual.dart';
import 'package:brainFit/src/pages/taskFingers.dart';
import 'package:brainFit/src/pages/taskHand.dart';
import 'package:brainFit/src/pages/taskMarcha.dart';
import 'package:brainFit/src/pages/uploadDual.dart';
import 'package:brainFit/src/pages/uploadVideo.dart';
import 'package:brainFit/src/pages/videoBradicinesia.dart';
import 'package:brainFit/src/pages/videoDualTask.dart';
import 'package:brainFit/src/pages/videoFingers.dart';
import 'package:brainFit/src/pages/videoHand.dart';
import 'package:brainFit/src/pages/videoMarcha.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brainFit/src/blocs/camera/camera_bloc.dart';
import 'package:brainFit/src/blocs/camera/camera_state.dart';
import 'package:brainFit/src/components/cameraComponent.dart';
import 'package:brainFit/src/components/cameraScreen.dart';
import 'package:brainFit/src/pages/bradicinesia.dart';
import 'package:brainFit/src/pages/home.dart';
import 'package:brainFit/src/pages/taskFist.dart';
import 'package:brainFit/src/pages/login_register_page.dart';
import 'package:brainFit/src/pages/principal.dart';
import 'package:brainFit/src/pages/listPatient.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => 
            CameraBloc(CameraState()))) 
      ],
      child: MaterialApp(
      title: "BrainFit",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoMono',
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/bradicinesia": (context) => const Bradicinesia(),
        "/taskFist": (context) => const TaskFist(),
        "/camera": (context) => const CameraComponent(),
        "/cameraScreen": (context) => CameraScreen(),
        "/playVideo": (context) => const VideoApp(),
        "/taskFingers": (context) => const TaskFingers(),
        "/taskHand": (context) => const TaskHand(),
        "/login": (context) => const LoginPage(),
        "/listVideo": (context) => const ListVideos(),
        "/principalPage": (context) => const principal(),
        "/createPatient": (context) => const CreatePatient(),
        "/listPatient": (context) => const ListPatient(),
        "/cameraBradicinesia": (context) => const CameraBradicinesia(),
        "/cameraFingers": (context) => const CameraFingers(),
        "/cameraHand": (context) => const CameraHand(),
        "/videoBradicinesia": (context) => const VideoBradicinesia(),
        "/videoFingers": (context) => const VideoFingers(),
        "/videoHand": (context) => const VideoHand(),
        "/uploadVideoBradicinesis": (context) => const UploadVideo(),
        "/buttonsTasks": (context) => const ButtonTaskDualTask(),
        "/taskMarcha": (context) => const TaskMarcha(),
        "/cameraMarcha": (context) => const CameraMarcha(),
        "/videoMarcha": (context) => const VideoMarcha(),
        "/taskDual": (context) => const TaskDual(),
        "/cameraDual": (context) => const CameraDualTask(),
        "/videoDual": (context) => const VideoDualTask(),
        "/uploadDual": (context) => const UploadVideoDual(),
      },
    ));
  }
}