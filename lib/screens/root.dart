import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';
import 'package:learnalist/routes/routes.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: Menu(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Top level'),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.close),
          tooltip: 'Closes application',
        ),
      ],
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('View lists.'),
            onTap: () {
              Navigator.popAndPushNamed(context, FindRoute.routePrefix);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('View a list via uuid only.'),
            onTap: () {
              Navigator.of(context).pushNamed(ViewListRoute.routePrefix,
                  arguments: ViewListRouteArguments(
                      '8b19f084-430d-5dc4-a7a1-f404c85a06b1'));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a simple list of items (v1).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v1'));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a list of  from -> to (v2).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v2'));
            },
          ),
          ListTile(
            leading: Icon(Icons.import_export),
            title: Text('Import / Export database'),
            onTap: () {
              _notImplementedYet(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _notImplementedYet(BuildContext context) async {
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
