import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/screens/list/view/list_view_v1.dart';
import 'package:learnalist/screens/list/view/list_view_v2.dart';
import 'package:learnalist/screens/list/view/list_view_v3.dart';
import 'package:learnalist/screens/list/view/list_view_v4.dart';
import 'package:learnalist/screens/list/view/list_view_not_found.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewListRoute extends StatelessWidget {
  static String routePrefix = '/list/view';

  @override
  Widget build(BuildContext context) {
    final ViewListRouteArguments args =
        ModalRoute.of(context).settings.arguments;
    Alist aList = ScopedModel.of<ListsRepository>(context)
        .aLists
        .singleWhere((aList) => aList.uuid == args.uuid, orElse: () => null);
    assert(aList.data != null);

    if (aList.info.listType == ListType.v1) {
      if (aList is! AlistV1) {
        aList = newAlistV1(aList);
      }
      return ListViewV1Screen(aList: aList);
    }

    if (aList.info.listType == ListType.v2) {
      if (aList is! AlistV2) {
        aList = newAlistV2(aList);
      }
      return ListViewV2Screen(aList: aList);
    }

    if (aList.info.listType == ListType.v3) {
      if (aList is! AlistV3) {
        aList = newAlistV3(aList);
      }
      return ListViewV3Screen(aList: aList);
    }

    if (aList.info.listType == ListType.v4) {
      if (aList is! AlistV4) {
        aList = newAlistV4(aList);
      }
      return ListViewV4Screen(aList: aList);
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
