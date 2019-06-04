import 'package:flutter/material.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:learnalist/routes/routes.dart';
import 'package:learnalist/importexport/root_route.dart';
import 'package:scoped_model/scoped_model.dart';

class LearnalistApp extends StatefulWidget {
  final String startAt;
  LearnalistApp({Key key, @required this.startAt}) : super(key: key);

  @override
  _LearnalistAppState createState() => _LearnalistAppState();
}

class _LearnalistAppState extends State<LearnalistApp> {
  @override
  Widget build(BuildContext context) {
    // TODO - Check on the state of the app.
    // TODO - Last screen?
    // TODO - should we show the options screen.

    var listsRepository = ScopedModel.of<ListsRepository>(context);
    listsRepository.loadLists();

    var startAt = RootRoute.routePrefix;
    if (widget.startAt.isNotEmpty) {
      startAt = widget.startAt;
    }

    final MaterialApp app = MaterialApp(
      title: 'Learnalist',
      initialRoute: startAt,
      routes: <String, WidgetBuilder>{
        RootRoute.routePrefix: (BuildContext context) => RootRoute(),
        FindRoute.routePrefix: (BuildContext context) => FindRoute(),
        PlayRoute.routePrefix: (BuildContext context) => PlayRoute(),
        CreateRoute.routePrefix: (BuildContext context) => CreateRoute(),
        CreateListV1Route.routePrefix: (BuildContext context) =>
            CreateListV1Route(),
        CreateListV2Route.routePrefix: (BuildContext context) =>
            CreateListV2Route(),
        CreateListV3Route.routePrefix: (BuildContext context) =>
            CreateListV3Route(),
        CreateListV4Route.routePrefix: (BuildContext context) =>
            CreateListV4Route(),
        ViewListRoute.routePrefix: (BuildContext context) => ViewListRoute(),
        EditListRoute.routePrefix: (BuildContext context) => EditListRoute(),
        // Import export
        ImportExportRootRoute.routePrefix: (BuildContext context) =>
            ImportExportRootRoute(),
        ServerOptionsRoute.routePrefix: (BuildContext context) =>
            ServerOptionsRoute(),
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

          if (args.listType == 'v3') {
            return MaterialPageRoute(
              builder: (context) {
                return CreateListV3Route();
              },
            );
          }

          if (args.listType == 'v4') {
            return MaterialPageRoute(
              builder: (context) {
                return CreateListV4Route();
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
      print('$k: $v');
    });

    return app;
  }
}
