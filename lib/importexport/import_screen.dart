import 'package:flutter/material.dart';
import 'package:learnalist/utils/shared.dart';
import 'package:learnalist/importexport/shared.dart';

class ImportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Import'),
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
                  actionButtonText: 'Import')
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
      print(uri);
      notImplementedYet(context);
    }
  }
}
