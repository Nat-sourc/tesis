import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBLocalBrainFit {
  static Future<Database> openDB() async {
    Database db = await openDatabase(join(await getDatabasesPath(), 'brainFit.db'),
        version: 1);
    return db;
  }

  static Future<Database> openDBWithCreateTables() async {
    Database db = await openDatabase(join(await getDatabasesPath(), 'brainFit.db'),
        version: 1);
    await createTables(db);
    return db;
  }

  static Future<bool> createTables(Database db) async {
    bool success = true;
    try {
      await db.execute(
        "CREATE TABLE IF NOT EXISTS archivo "
        "(id INTEGER PRIMARY KEY, "
        "idPaciente TEXT, "
        "idDoctor INTEGER, "
        "path TEXT, "
        "fecha TEXT, "
        "estado INTEGER) ",
      );
    } on Exception catch (e) {
      success = false;
    }
    return success;
  }
}
