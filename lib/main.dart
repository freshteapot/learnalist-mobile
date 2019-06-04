import 'package:flutter/material.dart';
import 'package:learnalist/app.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:learnalist/storage/database.dart';
import 'package:learnalist/services/credentials.dart';
import 'package:learnalist/services/api.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  DatabaseStorage databaseStorage = new DatabaseStorage();
  // There must be a cleaner way.
  await databaseStorage.init();

  var db = await databaseStorage.getDatabase();
  var credentials = Credentials(db);
  await credentials.load();

  String startAt = '/';
  if (!credentials.isVerified()) {
    startAt = '/server_options';
  }

  var api = Api(credentials);
  final listsRepository = ListsRepository(
      storage: databaseStorage, credentials: credentials, api: api);
  runApp(
    ScopedModel<ListsRepository>(
      // Here's where we provide the model to any interested widget below.
      model: listsRepository,
      child: LearnalistApp(startAt: startAt),
    ),
  );
}
