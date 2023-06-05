import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_onedrive/flutter_onedrive.dart';

class OneDriveComponent extends StatelessWidget {
  const OneDriveComponent({super.key});

  @override
  Widget build(BuildContext context) {
    print("LLEGUEEE A ONDE DRIVE");
    final onedrive = OneDrive(redirectURL: "/bradicinesia", clientID: "ymm8Q~daZnwom3LvkGf912oogJF1eI2IZb69SbHffyC");

    return FutureBuilder(
      future: onedrive.isConnected(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          print("ENTRE OPCION 1");
          print(snapshot.connectionState);
          print(snapshot.error);
          print(snapshot.data);
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data ?? false) {
          print("ENTRE OPCION 2");
          // Has connected
          return const Text("Connected");
        } else {
          print("ENTRE OPCION 3");
          print(snapshot.connectionState);
          print(snapshot.error);
          print(snapshot.data);
          // Hasn't connected
          return MaterialButton(
            child: const Text("Connect"),
            onPressed: () async {
              final success = await onedrive.connect(context);
              if (success) {
                // Download files
                final txtBytes = await onedrive.pull("/xxx/xxx.txt");
                // Upload files
                //var file = File.f
                await onedrive.push(txtBytes!, "/xxx/xxx.txt");
              }
            },
          );
        }
      },
    );
  }
}