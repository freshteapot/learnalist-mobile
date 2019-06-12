import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';

class RecallHistoryV2 extends StatelessWidget {
  final AlistV2 aList;
  final List<String> items;

  RecallHistoryV2({Key key, @required this.aList, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return ListView.builder(
      padding: const EdgeInsets.only(left: 32.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item =
            aList.getItems().firstWhere((item) => item.to == items[index]);
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${item.to}',
            style: localTheme.textTheme.body2,
          ),
          subtitle: Text(
            '${item.from}',
            style: localTheme.textTheme.body1.copyWith(color: Colors.grey),
          ),
        );
      },
    );
  }
}
