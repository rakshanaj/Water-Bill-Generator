import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, 'test.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Readings ("
          "current INTEGER PRIMARY KEY,"
          "house TEXT,"
          "month TEXT,"
          "year TEXT"
          ")");
    });
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }
}
