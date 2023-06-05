import 'package:brainFit/src/dbsqlite/archivoEntity.dart';
import 'package:brainFit/src/model/dominio/archivoDB.dart';

class ArchivoRepo{
  Future<List<ArchivoDB>> getAll() async {
    List<ArchivoDB> tslist = await ArchivoEntity.getAll();
    return tslist;
  }


  Future<int> insert(ArchivoDB archivo) async {
    int res = await ArchivoEntity.insert(archivo);
    return res;
  }

  Future<int> update(ArchivoDB archivo) async {
    int res = await ArchivoEntity.update(archivo);
    return res;
  }

  Future<int> delete(ArchivoDB archivo) async {
    int res = await ArchivoEntity.delete(archivo);
    return res;
  }

  Future<int> deleteAll() async {
    int res = await ArchivoEntity.deleteAll();
    return res;
  }

}