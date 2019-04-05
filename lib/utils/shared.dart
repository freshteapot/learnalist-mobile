import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> notImplementedYet(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('//TODO'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text('This feature exists in the future.')],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('I want to live in the present.'),
            onPressed: () {
              print('Back to the future.');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void lsAppDirectory() async {
  String directory = (await getApplicationDocumentsDirectory()).path;
  var dir = Directory("$directory/");
  var files = dir.listSync(recursive: true);
  files.forEach((f) {
    print(f);
  });
}
