import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/widgets/list_edit_list_info.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/screens/list/edit/list_edit_v4_item.dart';
import 'package:learnalist/screens/list/list_delete.dart';

// Create a Form Widget
class ListEditV4Screen extends StatefulWidget {
  final AlistV4 aList;

  ListEditV4Screen({Key key, @required this.aList}) : super(key: key);

  @override
  ListEditV4ScreenState createState() {
    return ListEditV4ScreenState();
  }
}

class ListEditV4ScreenState extends State<ListEditV4Screen> {
  void onSaveListInfo(String value) {
    bool hasChanged = widget.aList.info.title != value;
    if (hasChanged) {
      widget.aList.info.title = value;

      ScopedModel.of<ListsRepository>(context, rebuildOnChange: true)
          .updateAlist(widget.aList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Edit Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListDeleteScreen(aList: widget.aList)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListEditItemV4Screen(aList: widget.aList)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          EditListInfo(
            aList: widget.aList,
            onSaved: onSaveListInfo,
          ),
          _buildListItems(widget.aList)
        ]),
      ),
    );
  }

  Widget _buildListItems(AlistV4 aList) {
    return Flexible(
        child: ScopedModelDescendant<ListsRepository>(
            builder: (context, child, storage) => ListView.builder(
                  padding: const EdgeInsets.all(32),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: aList.getItems().length,
                  itemBuilder: (context, index) {
                    final item = aList.getItems()[index];
                    return Dismissible(
                        key: Key(item.hashCode.toString() +
                            aList.getItems().length.toString()),
                        onDismissed: (direction) {
                          // Remove the item from our data source.

                          aList.removeItem(index);
                          ScopedModel.of<ListsRepository>(context)
                              .updateAlist(aList);
                        },
                        // Show a red background as the item is swiped away
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(item.content),
                          subtitle: Text(item.url),
                        ));
                  },
                )));
  }
}
