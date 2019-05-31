import 'dart:convert';
import 'package:learnalist/models/server_credentials.dart';

void main() {
  var input = ServerCredentialsInput(
      username: 'freshteapot', password: '', server: SERVER_HINT);

  var credentials = ServerCredentials(
      server: input.server,
      username: input.username,
      basicAuth: input.getBasicAuth());

  print(credentials);
  print(credentials.basicAuth);
}
