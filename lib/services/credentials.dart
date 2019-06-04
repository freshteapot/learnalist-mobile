import 'package:learnalist/models/server_credentials.dart';
import 'package:sqflite/sqflite.dart';

/*
CREATE TABLE server_credentials (
  server text NOT NULL,
  username text NOT NULL,
  basic_auth text NOT NULL
);

INSERT INTO server_credentials (server, username, basic_auth) VALUES('https', 'f', 'b');
SELECT * FROM server_credentials;
DELETE FROM server_credentials;
*/
/// The service responsible for networking requests
class Credentials {
  Database _database;
  ServerCredentials _current;

  Credentials(Database database) {
    _database = database;
    _current = ServerCredentials();
  }

  String getServer() {
    return _current.server;
  }

  String getUsername() {
    return _current.username;
  }

  String getBasicAuth() {
    return _current.basicAuth;
  }

  // Simple verification to speculate the user can
  // query the api.
  bool isVerified() {
    if (_current.server.isEmpty) {
      return false;
    }
    if (_current.username.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> load() async {
    var db = _database;
    List<Map> result = await db.rawQuery("SELECT * FROM server_credentials;");

    if (result.isNotEmpty) {
      Map credentialsMap = result[0];
      _current = new ServerCredentials(
          server: credentialsMap['server'],
          username: credentialsMap['username'],
          basicAuth: credentialsMap['basic_auth']);
    } else {
      _current = new ServerCredentials(
          server: SERVER_HINT, username: '', basicAuth: '');
    }
  }

  Future<void> clear() async {
    var db = _database;
    await db.rawDelete("DELETE FROM server_credentials;");
    _current = new ServerCredentials(server: '', username: '', basicAuth: '');
    await load();
  }

  Future<void> save(ServerCredentials credentials) async {
    // DELETE FROM server_credentials;
    // INSERT INTO server_credentials
    //var current = ServerCredentials(username: 'freshteapot', basicAuth: 'FAKE', server: SERVER_HINT);
    await clear();
    var db = _database;
    await db.rawInsert(
        "INSERT INTO server_credentials (server, username, basic_auth) VALUES(?,?,?);",
        [credentials.server, credentials.username, credentials.basicAuth]);
    print('Reload the data.');
    _current = new ServerCredentials(server: '', username: '', basicAuth: '');
    await load();
  }
}
