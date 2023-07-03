import 'package:path_provider/path_provider.dart' as path_provider;
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
  bool isBradicinesisButtonEnabled = false;
  bool isDualTaskButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SingleChildScrollView(
                child: Scrollbar(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('pacientes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final pacientes = snapshot.data?.docs;
                        final filteredPacientes = pacientes?.where((paciente) {
                          final cedula =
                              paciente['id'].toString().toLowerCase();
                          return cedula.contains(searchText);
                        }).toList();
                        return Scrollbar(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredPacientes?.length ?? 0,
                            itemBuilder: (context, index) {
                              final paciente = filteredPacientes?[index];
                              final idPatient = paciente?['id'];
                              final isGray =
                                  idPatient.toString().contains('gray');
                              final color = isGray ? Colors.grey : Colors.white;
                              final isSelected = idPatient == selectedCedula;
                              final completeBradicinesis =
                                  paciente?['completeBradicinesis'];
                              final completeTask =
                                  paciente?['completetask'];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCedula = idPatient;
                                    isBradicinesisButtonEnabled =
                                        completeBradicinesis == false;
                                    isDualTaskButtonEnabled =
                                        completeTask == false; // Habilitar si completeTask es false
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: isSelected ? 2 : 0,
                                    ),
                                  ),
                                  height: 40,
                                  child: Container(
                                    color: isGray
                                        ? const Color.fromARGB(
                                            255, 198, 183, 183)
                                        : color,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Center(
                                      child: Text(
                                        idPatient.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected
                                              ? Color.fromARGB(
                                                  255, 44, 195, 190)
                                              : Colors.black,
                                        ),
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
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isBradicinesisButtonEnabled &&
                            selectedCedula != null
                        ? () => showPantallaBradicinesia(
                            "/buttonBradicinesis", selectedCedula!)
                        : null,
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
                    onPressed: isDualTaskButtonEnabled &&
                            selectedCedula != null
                        ? () => showPantallaBradicinesia(
                            "/buttonsTasks", selectedCedula!)
                        : null,
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

  void showPantallaBradicinesia(String ruta, String? idPaciente) {
    Navigator.of(context).pushNamed(ruta, arguments: idPaciente);
  }
}
