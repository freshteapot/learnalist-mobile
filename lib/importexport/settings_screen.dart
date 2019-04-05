import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Import Export'),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.close),
          tooltip: 'Closes application',
          onPressed: () {
            print('Close the app or something');
          },
        ),
      ],
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_upward),
            title: Text('Import'),
            onTap: () {
              print('Import');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.arrow_downward),
            title: Text('Export'),
            onTap: () {
              print('Export');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              print('Settings');
            },
          ),
        ],
      ),
    );
  }
}
