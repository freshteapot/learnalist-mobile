import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:learnalist/importexport/export_database.dart';
import 'package:learnalist/utils/shared.dart';
import 'package:learnalist/importexport/shared.dart';

class ExportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Export'),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Material(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ImportExportForm(
                  actionButtonPressed: actionButtonPressed,
                  actionButtonText: 'Export')
            ],
          )),
    );
  }

  Future<void> actionButtonPressed(BuildContext context,
      GlobalKey<FormState> formKey, UriInput uriInput) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var uri = Uri(
          scheme: uriInput.scheme,
          host: uriInput.host,
          port: uriInput.port,
          path: uriInput.path);

      bool result = await zipIt(uri);

      if (!result) {
        notImplementedYet(context);
      } else {
        // TODO return an indication if it worked.
        Navigator.pop(context);
      }
    }
  }

  Future<bool> zipIt(Uri uri) async {
    String appDirectory = (await getApplicationDocumentsDirectory()).path;
    String databasePath = '$appDirectory/database.json';
    try {
      var export = ExportDatabase(appDirectory: appDirectory);
      await export.init();
      export.addFile(databasePath);
      return export.post(uri);
    } catch (e) {
      return false;
    }
  }
}
