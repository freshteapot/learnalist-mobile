import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseStorage {
  Database _database;
  bool _initCalled = false;

  Future<Database> init() async {
    _initCalled = true;
    _database = await this._loadDatabase();
    return _database;
  }

  void dispose() {
    _database = null;
  }

  Future<Database> getDatabase() async {
    assert(_initCalled, 'Was the database loaded via init().');
    return this._database;
  }

  Future<Database> _loadDatabase() async {
    var dbName = 'mobile-api.db';
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      var credentialsTable = """
CREATE TABLE server_credentials (
  server text NOT NULL,
  username text NOT NULL,
  basic_auth text NOT NULL
);
      """;
      await db.execute(credentialsTable);
    });

    return database;
  }
}
