import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onedrive/flutter_onedrive.dart';
import 'package:http/http.dart' as http;
import 'package:brainFit/src/components/titleImg.dart';

class TestOneDrive extends StatelessWidget {
  const TestOneDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 100.0,
                )
              ],
            ),
            const TitleImg(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/fist.png",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SOY TEST",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 30))
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 50.0,
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                      "Abrir y cerrar la mano haciendo un movimiento de puño",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 18)),
                )
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 50.0,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/OneDrive")},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: Size(350, 50),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text("Comencemos",
                      style: TextStyle(
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 20)), 
                )
              ],
            ),
      ]),
      ),
    );
  }

  Future<String> getAccessToken() async {
    var clientId = 'f8cdef31-a31e-4b4a-93e4-5f571e91255a';
    var clientSecret = 'b7de3fd5-08a0-4214-8e6c-1173e8e1ae6c';
    var scope = 'https://graph.microsoft.com/.default';
    var tokenEndpoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';

    var response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'scope': scope,
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var accessToken = responseBody['access_token'];
      return accessToken;
    } else {
      throw Exception('Failed to obtain access token.');
    }
  }

  
}