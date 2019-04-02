import 'package:flutter/material.dart';
import 'package:learnalist/app.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final listsRepository = ListsRepository();
  listsRepository.loadLists();

  runApp(
    ScopedModel<ListsRepository>(
      // Here's where we provide the model to any interested widget below.
      model: listsRepository,
      child: LearnalistApp(),
    ),
  );
}
