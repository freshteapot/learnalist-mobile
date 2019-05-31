import 'dart:convert';

const String SERVER_HINT = 'https://learnalist.net/api/v1';

class ServerCredentialsInput {
  String server;
  String username;
  String password;

  ServerCredentialsInput(
      {this.server = SERVER_HINT, this.username = '', this.password = ''});

  String getBasicAuth() {
    var basicAuth = base64Encode(utf8.encode('$username:$password'));
    return basicAuth;
  }
}

class ServerCredentials {
  final String server;
  final String username;
  final String basicAuth;

  ServerCredentials({this.server, this.username, this.basicAuth});

  @override
  String toString() {
    return 'ServerCredentials{server: $server, username: $username, basicAuth: na}';
  }
}
