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
                    labelText: 'Buscar ID Paciente o Fecha',
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
                          final fechaCreacion = paciente['fechaCreacion'];
                          final formattedDate =
                              _formatDate(fechaCreacion)?.toLowerCase();
                          return cedula.contains(searchText) ||
                              formattedDate!.contains(searchText);
                        }).toList();
                        return Scrollbar(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredPacientes?.length ?? 0,
                            itemBuilder: (context, index) {
                              final paciente = filteredPacientes?[index];
                              final idPatient = paciente?['id'];
                              final fechaCreacion = paciente?['fechaCreacion'];
                              final isGray =
                                  idPatient.toString().contains('gray');
                              final color = isGray ? Colors.grey : Colors.white;
                              final isSelected = idPatient == selectedCedula;
                              final completeBradicinesis =
                                  paciente?['completeBradicinesis'];
                              final completeTask = paciente?['completetask'];

                              final formattedDate = _formatDate(fechaCreacion);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCedula = idPatient;
                                    isBradicinesisButtonEnabled =
                                        completeBradicinesis == false;
                                    isDualTaskButtonEnabled =
                                        completeTask == false;
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
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        color: isGray
                                            ? const Color.fromARGB(
                                                255, 198, 183, 183)
                                            : color,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
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
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 10.0,
                                        ),
                                        color: isGray
                                            ? const Color.fromARGB(
                                                255, 198, 183, 183)
                                            : color,
                                        child: Text(
                                          '$formattedDate',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
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
                    onPressed:
                        isBradicinesisButtonEnabled && selectedCedula != null
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
                      "Bradicinesia",
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: isDualTaskButtonEnabled && selectedCedula != null
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
              const Row(
                children: [
                  SizedBox(
                    width: 10.0,
                    height: 20.0,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => {showPantalla("/principalPage")},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Atrás",
                    style:
                        TextStyle(fontFamily: 'RobotoMono-Bold', fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _formatDate(Timestamp? timestamp) {
    if (timestamp != null) {
      final dateTime = timestamp.toDate();
      final day = dateTime.day;
      final month = _getMonthName(dateTime.month);
      final year = dateTime.year;
      return '$day de $month de $year';
    }
    return null;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'enero';
      case 2:
        return 'febrero';
      case 3:
        return 'marzo';
      case 4:
        return 'abril';
      case 5:
        return 'mayo';
      case 6:
        return 'junio';
      case 7:
        return 'julio';
      case 8:
        return 'agosto';
      case 9:
        return 'septiembre';
      case 10:
        return 'octubre';
      case 11:
        return 'noviembre';
      case 12:
        return 'diciembre';
      default:
        return '';
    }
  }

  void showPantallaBradicinesia(String ruta, String? idPaciente) {
    Navigator.of(context).pushNamed(ruta, arguments: idPaciente);
  }

  void showPantalla(String ruta) {
    Navigator.of(context).pushNamed(ruta);
  }
}
