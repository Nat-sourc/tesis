import 'package:brainFit/src/dbsqlite/DBLocalBrainFit.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';
import 'package:sqflite/sqflite.dart';

class ArchivoEntity {
  static Future<int> insert(ArchivoDB archivo) async {
    Database database = await DBLocalBrainFit.openDB();
    print(archivo.toJson());
    return database.insert("archivo", archivo.toJson());
  }

  static Future<int> delete(ArchivoDB archivo) async {
    Database database = await DBLocalBrainFit.openDB();

    return database.delete("archivo", where: "id = ?", whereArgs: [archivo.id]);
  }

  static Future<int> deleteAll() async {
    Database database = await DBLocalBrainFit.openDB();

    return database.delete("archivo");
  }

  static Future<int> update(ArchivoDB archivo) async {
    Database database = await DBLocalBrainFit.openDB();

    return database.update("archivo", archivo.toJson(),
        where: "id = ?", whereArgs: [archivo.id]);
  }

  static Future<List<ArchivoDB>> getAll() async {
    Database database = await DBLocalBrainFit.openDB();
    final List<Map<String, dynamic>> archivoMap =
        await database.query("archivo");

    return List.generate(
        archivoMap.length,
        (i) => ArchivoDB(
              id: archivoMap[i]["id"],
              idPaciente: archivoMap[i]["idPaciente"],
              idDoctor: archivoMap[i]["idDoctor"],
              path: archivoMap[i]["path"],
              fecha: archivoMap[i]["fecha"],
              estado: archivoMap[i]["estado"],
            ));
  }
}
