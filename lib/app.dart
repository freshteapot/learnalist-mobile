import 'package:flutter/material.dart';
import 'package:learnalist/routes/routes.dart';
import 'package:learnalist/importexport/root_route.dart';

class LearnalistApp extends StatefulWidget {
  @override
  _LearnalistAppState createState() => _LearnalistAppState();
}

class _LearnalistAppState extends State<LearnalistApp> {
  @override
  Widget build(BuildContext context) {
    final MaterialApp app = MaterialApp(
      title: 'Learnalist',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        RootRoute.routePrefix: (BuildContext context) => RootRoute(),
        FindRoute.routePrefix: (BuildContext context) => FindRoute(),
        PlayRoute.routePrefix: (BuildContext context) => PlayRoute(),
        CreateRoute.routePrefix: (BuildContext context) => CreateRoute(),
        CreateListV1Route.routePrefix: (BuildContext context) =>
            CreateListV1Route(),
        CreateListV2Route.routePrefix: (BuildContext context) =>
            CreateListV2Route(),
        ViewListRoute.routePrefix: (BuildContext context) => ViewListRoute(),
        EditListRoute.routePrefix: (BuildContext context) => EditListRoute(),
        // Import export
        ImportExportRootRoute.routePrefix: (BuildContext context) =>
            ImportExportRootRoute(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/create/list') {
          final CreateListRouteArguments args = settings.arguments;

          if (args.listType == 'v1') {
            return MaterialPageRoute(
              builder: (context) {
                return CreateListV1Route();
              },
            );
          }

          if (args.listType == 'v2') {
            return MaterialPageRoute(
              builder: (context) {
                return CreateListV2Route();
              },
            );
          }
        }
        return null;
      },
    );

    // Show the routes in the app and the class.
    // TODO remove before production?
    app.routes.forEach((k, v) {
      print('${k}: ${v}');
    });

    return app;
  }
}
