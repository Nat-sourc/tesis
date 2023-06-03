import 'package:flutter/material.dart';
import 'package:nombre_del_proyecto/src/pages/bradicinesia.dart';
import 'package:nombre_del_proyecto/src/pages/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "BrainFit",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoMono',
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/bradicinesia": (context) => const Bradicinesia(),
      },
    );
  }
}