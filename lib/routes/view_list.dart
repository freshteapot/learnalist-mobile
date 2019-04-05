import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/screens/list/view/list_view_v1.dart';
import 'package:learnalist/screens/list/view/list_view_v2.dart';
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
    // TODO remove when this stops happening.
    if (aList.listData == null) {
      print('Why is the listdata null');
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
