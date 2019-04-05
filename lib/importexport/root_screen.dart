import 'package:flutter/material.dart';
import 'package:learnalist/importexport/import_screen.dart';
import 'package:learnalist/importexport/export_screen.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(title: Text('Import Export'));
  }

  Widget _buildScreen(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_upward),
            title: Text('Import'),
            onTap: () async {
              _openDialog(context, ImportScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.arrow_downward),
            title: Text('Export'),
            onTap: () async {
              _openDialog(context, ExportScreen());
            },
          )
        ],
      ),
    );
  }
}

Future _openDialog(BuildContext context, Widget screen) async {
  String save = await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return screen;
      },
      fullscreenDialog: true));
  print(save);
}
