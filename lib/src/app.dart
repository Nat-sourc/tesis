import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nombre_del_proyecto/src/blocs/camera/camera_bloc.dart';
import 'package:nombre_del_proyecto/src/blocs/camera/camera_state.dart';
import 'package:nombre_del_proyecto/src/components/cameraExampleHome.dart';
import 'package:nombre_del_proyecto/src/pages/bradicinesia.dart';
import 'package:nombre_del_proyecto/src/pages/home.dart';
import 'package:nombre_del_proyecto/src/pages/taskFist.dart';

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
        "/camera": (context) => const CameraExampleHome(),
      },
    ));
  }
}