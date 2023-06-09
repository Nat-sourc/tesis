import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brainFit/src/components/titleImg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({Key? key}) : super(key: key);

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  String? selectedCedula;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TitleImg(),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "Lista de Pacientes",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Buscar ID Paciente',
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('pacientes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pacientes = snapshot.data?.docs; // Add null check here
                    final filteredPacientes = pacientes?.where((paciente) {
                      final cedula = paciente['id'].toString().toLowerCase();
                      return cedula.contains(searchText);
                    }).toList();
                    return Column(
                      children: List.generate(
                        filteredPacientes?.length ?? 0,
                        (index) {
                          final paciente = filteredPacientes?[index];
                          final cedula = paciente?['id'];
                          final isGray = cedula.toString().contains('gray'); // Example condition for gray color
                          final color = isGray ? Colors.grey : Colors.white;
                          final isSelected = cedula == selectedCedula;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCedula = cedula;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0), // Espacio entre cada cuadrado
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: isSelected ? 2 : 0,
                                ),
                              ),
                              height: 40,
                              width: 300,
                              child: Container(
                                color: isGray ? const Color.fromARGB(255, 198, 183, 183) : color,
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  cedula.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected ? Color.fromARGB(255, 44, 195, 190) : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error al obtener la lista de pacientes');
                  }
                  return CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {showPantallaBradicinesia("/bradicinesia")},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Bradicinesis",
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () => {showPantallaBradicinesia("")},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Dual-Task",
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPantallaBradicinesia(String ruta) {
    Navigator.of(context).pushNamed(ruta);
  }
}
