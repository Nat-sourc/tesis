import 'dart:io';

import 'package:brainFit/src/components/titleImg.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:brainFit/src/repository/archivoRepo.dart';
import 'package:brainFit/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({super.key});

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {

  final columnas = [
    'id',
    'idPaciente',
    'idDoctor',
    'path',
    'fecha',
    'estado',
  ];
  late List<ArchivoDB> lista = [];
  bool isAscending = false;
  int? sortColumnIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      lista = await getListVideos();
      lista.forEach((element) {
        print(element.path);
       });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(children: [
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 100.0,
                )
              ],
            ),
            const TitleImg(),
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 50.0,
                )
              ],
            ),
            getFormaListaArchivos(),
            const Row(
              children: [
                SizedBox(
                  width: 30.0,
                  height: 50.0,
                )
              ],
            ),
            ElevatedButton(
                  onPressed: () async {
                    //await iniciarCamara();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed('/camera');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 191, 166),
                    minimumSize: Size(350, 50),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text("Subir videos",
                      style: TextStyle(
                          fontFamily: 'RobotoMono-Bold',
                          fontSize: 20)), 
                ),
      ]),
      ),
    );
  }

  Widget getFormaListaArchivos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[getTabla()]),
              //Row(children: <Widget>[getBotonesAccion()]),
            ],
          )),
    );
  }

  Future<List<ArchivoDB>> getListVideos() async {
    ArchivoRepo archivoRepo = ArchivoRepo();
    List<ArchivoDB> lista = await archivoRepo.getAll();
    return lista;
  }

  Widget getTabla() {
    return DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columnas),
        rows: getRows(lista));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String columna) => DataColumn(
            label: Text(columna),
            onSort: onSort,
          ))
      .toList();


  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      lista.sort((archivo1, archivo2) => compareString(
          ascending, '${archivo1.id}', '${archivo2.id}'));
    } else if (columnIndex == 1) {
      lista.sort((archivo1, archivo2) => compareString(
          ascending, '${archivo1.idPaciente}', '${archivo2.idPaciente}'));
    } else if (columnIndex == 2) {
      lista.sort((archivo1, archivo2) => compareString(
          ascending, '${archivo1.idDoctor}', '${archivo2.idDoctor}'));
    } else if (columnIndex == 3) {
      lista.sort((archivo1, archivo2) => compareString(
          ascending,
          '${archivo1.path}',
          '${archivo2.path}'));
    } else if (columnIndex == 4) {
      lista.sort((archivo1, archivo2) => compareString(ascending,
          '${archivo1.fecha}', '${archivo2.fecha}'));
    } else if (columnIndex == 5) {
      lista.sort((archivo1, archivo2) => compareString(ascending,
          '${archivo1.estado}', '${archivo2.estado}'));
    }
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  List<DataRow> getRows(List<ArchivoDB> archivos) =>
      archivos.map((ArchivoDB archivo) {
        final cells = [
          archivo.id,
          archivo.idPaciente,
          archivo.idDoctor,
          archivo.path,
          archivo.fecha,
          archivo.estado,

        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            if (archivo.estado! > 0) {
              index = 1;
            }
            final showEditIcon = index == 0;

            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.popAndPushNamed(context, '/estacionedit',
                        arguments: archivo);
                    break;
                }
              },
            );
          }),
        );
      }).toList();
  
}