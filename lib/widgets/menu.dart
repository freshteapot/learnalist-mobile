import 'package:flutter/material.dart';
import 'package:learnalist/routes/routes.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Top Level'),
            onTap: () {
              Navigator.of(context).pushNamed(RootRoute.routePrefix);
            },
          ),
          ListTile(
            title: Text('Find Lists'),
            onTap: () {
              Navigator.of(context).pushNamed(FindRoute.routePrefix);
            },
          ),
          ListTile(
            title: Text('Create a list'),
            onTap: () {
              Navigator.of(context).pushNamed(CreateRoute.routePrefix);
            },
          ),
          ListTile(
            title: Text('Play'),
            onTap: () {
              Navigator.of(context).pushNamed(PlayRoute.routePrefix);
            },
          ),
          ListTile(
            title: Text('Server Options'),
            onTap: () {
              Navigator.of(context).pushNamed(ServerOptionsRoute.routePrefix);
            },
          ),
        ],
      ),
      elevation: 20.0,
    );
  }
}
