import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/screens/list/edit/list_edit_v1.dart';
import 'package:learnalist/screens/list/edit/list_edit_v2.dart';
import 'package:learnalist/screens/list/edit/list_edit_not_found.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/models/lists_repository.dart';

class EditListRoute extends StatelessWidget {
  static String routePrefix = '/list/edit';

  @override
  Widget build(BuildContext context) {
    final EditListRouteArguments args =
        ModalRoute.of(context).settings.arguments;
    Alist aList;
    // If the app is parsing the list we use the object otherwise we do a lookup.
    if (args.aList != null) {
      aList = args.aList;
    } else {
      // TODO Use real storage
      aList = ScopedModel.of<ListsRepository>(context)
          .aLists
          .singleWhere((aList) => aList.uuid == args.uuid, orElse: () => null);
    }

    if (aList.info.listType == ListType.v1) {
      if (aList is! AlistV1) {
        aList = newAlistV1(aList);
      }
      return ListEditV1Screen(aList: aList);
    }
    if (aList.info.listType == ListType.v2) {
      if (aList is! AlistV2) {
        aList = newAlistV2(aList);
      }
      return ListEditV2Screen(aList: aList);
    }
    // TODO return an error page for lists
    return ListEditNotFoundScreen();
  }
}

class EditListRouteArguments {
  final String uuid;
  final Alist aList;
  EditListRouteArguments(this.uuid, {this.aList});
}
