import 'package:flutter/material.dart';
import 'package:learnalist/widgets/menu.dart';
import 'package:learnalist/routes/routes.dart';
import 'package:learnalist/importexport/root_route.dart';
import 'package:learnalist/utils/shared.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: Menu(),
      body: _buildScreen(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Top level'),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            print('Close the app or something');
            notImplementedYet(context);
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
            leading: Icon(Icons.add_box),
            title: Text('View lists.'),
            onTap: () {
              Navigator.of(context).pushNamed(FindRoute.routePrefix);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a simple list of items (v1).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v1'));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Create a list of  from -> to (v2).'),
            onTap: () {
              Navigator.of(context).pushNamed('/create/list',
                  arguments: CreateListRouteArguments('v2'));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.import_export),
            title: Text('Import / Export database'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ImportExportRootRoute.routePrefix);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('View a list via uuid only.'),
            onTap: () {
              Navigator.of(context).pushNamed(ViewListRoute.routePrefix,
                  arguments: ViewListRouteArguments(
                      '8b19f084-430d-5dc4-a7a1-f404c85a06b1'));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Samples of a timer.'),
            onTap: () {
              Navigator.of(context).pushNamed('/samples/atimer');
            },
          ),
        ],
      ),
    );
  }
}
