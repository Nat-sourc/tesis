import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePatient extends StatefulWidget {
   const CreatePatient({super.key});

  @override
  _CreatePatientState createState() => _CreatePatientState();
}

class _CreatePatientState extends State<CreatePatient> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  String _selectedGender = "";

  void _addPatient() {
    String id = _idController.text;

    // Verificar que se haya seleccionado un género
    if (_selectedGender != null) {
      // Realizar la consulta para verificar si el paciente ya existe
      _firestore.collection('pacientes').doc(id).get().then((snapshot) {
        if (snapshot.exists) {
          // Mostrar alerta si el paciente ya existe
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Paciente existente'),
                content: Text('El paciente ya ha sido agregado anteriormente.'),
                actions: [
                  TextButton(
                    child: Text('Aceptar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Obtener la fecha actual
          DateTime now = DateTime.now();
          Timestamp fechaCreacion = Timestamp.fromDate(now);

          // Guardar los datos del paciente en Firebase Firestore
          _firestore.collection('pacientes').doc(id).set({
            'id': id,
            'genero': _selectedGender,
            'fechaCreacion': fechaCreacion,
            'completeTaskBradicinesis': false,
            'completeBradicinesis': false,
            'taskaudio': false,
            'taskmarcha': false,
            'taskArm': false,
            'dualtask': false,
            'completetask': false,
          }).then((value) {
            // Éxito al guardar los datos
            print('Paciente agregado exitosamente');
            Fluttertoast.showToast(
              msg: 'Paciente agregado exitosamente',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Color.fromARGB(255, 45, 205, 144),
              textColor: Colors.white,
            );
            Navigator.pushNamed(context, "/principalPage");
          }).catchError((error) {
            // Error al guardar los datos
            print('Error al agregar el paciente: $error');
            Fluttertoast.showToast(
              msg: 'Error al agregar el paciente: $error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Color.fromARGB(255, 45, 205, 144),
              textColor: Colors.white,
            );
          });
        }
      }).catchError((error) {
        // Error al realizar la consulta
        print('Error al verificar el paciente: $error');
        Fluttertoast.showToast(
          msg: 'Error al verificar el paciente: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 45, 205, 144),
          textColor: Colors.white,
        );
      });
    } else {
      // Mostrar mensaje de error si no se ha seleccionado un género
      print('Seleccione un género');
      Fluttertoast.showToast(
        msg: 'Seleccione un género',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 45, 205, 144),
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              const TitleImg(),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "Paciente Nuevo con el ID",
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
              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ID del paciente',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Seleccione género del paciente",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedGender = 'Femenino';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender == 'Femenino'
                          ? const Color.fromARGB(255, 91, 146, 153)
                          : const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Femenino",
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedGender = 'Masculino';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender == 'Masculino'
                          ? const Color.fromARGB(255, 91, 146, 153)
                          : const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Masculino",
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: _addPatient,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Agregar Paciente",
                  style: TextStyle(
                    fontFamily: 'RobotoMono-Bold',
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
