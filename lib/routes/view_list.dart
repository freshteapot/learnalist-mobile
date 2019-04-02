import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/screens/list_view_v1.dart';
import 'package:learnalist/screens/list_view_v2.dart';
import 'package:learnalist/screens/list_view_not_found.dart';

// TODO move to be dynamic
final List<Alist> listOfLists = getLists();

class ViewListRoute extends StatelessWidget {
  static String routePrefix = '/list/view';

  @override
  Widget build(BuildContext context) {
    final ViewListRouteArguments args =
        ModalRoute.of(context).settings.arguments;
    Alist aList;
    // If the app is parsing the list we use the object otherwise we do a lookup.
    if (args.aList != null) {
      aList = args.aList;
    } else {
      // TODO Use real storage
      aList = listOfLists.singleWhere((aList) => aList.uuid == args.uuid,
          orElse: () => null);
    }

    if (aList.listInfo.listType == ListType.v1) {
      if (aList is! AlistV1) {
        aList = newAlistV1(aList);
      }
      return ListViewV1Screen(aList: aList);
    }
    if (aList.listInfo.listType == ListType.v2) {
      if (aList is! AlistV2) {
        aList = newAlistV2(aList);
      }
      return ListViewV2Screen(aList: aList);
    }

    // TODO return an error page for lists
    return ListViewNotFoundScreen();
  }
}

class ViewListRouteArguments {
  final String uuid;
  final Alist aList;
  ViewListRouteArguments(this.uuid, {this.aList});
}
