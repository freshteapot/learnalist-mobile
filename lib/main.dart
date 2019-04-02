import 'package:flutter/material.dart';
import 'package:learnalist/app.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:learnalist/storage/file.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  FileStorage fileStorage = FileStorage();
  final listsRepository = ListsRepository(fileStorage);
  listsRepository.loadLists().then((success) {
    runApp(
      ScopedModel<ListsRepository>(
        // Here's where we provide the model to any interested widget below.
        model: listsRepository,
        child: LearnalistApp(),
      ),
    );
  });
}
