import 'package:brainFit/src/components/videoApp.dart';
import 'package:brainFit/src/pages/listVideos.dart';
import 'package:brainFit/src/pages/taskFingers.dart';
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
        "/listVideo": (context) => const ListVideos(),
      },
    ));
  }
}