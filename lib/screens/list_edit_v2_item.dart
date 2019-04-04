import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListEditItemV2Screen extends StatelessWidget {
  final AlistV2 aList;

  ListEditItemV2Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          V1ListItemV2Form(aList),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class V1ListItemV2Form extends StatefulWidget {
  final Alist aList;

  V1ListItemV2Form(this.aList);

  @override
  V1ListItemV2FormState createState() {
    return V1ListItemV2FormState();
  }
}

class V1ListItemV2FormState extends State<V1ListItemV2Form> {
  final _formKey = GlobalKey<FormState>();
  AlistItemTypeV2 newItem;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    newItem = new AlistItemTypeV2('', '');
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'From:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          newItem.from = value;
                        }),
                    TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'To:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          newItem.to = value;
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                            newItem = new AlistItemTypeV2('', '');
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              widget.aList.listData.add(newItem);

                              _formKey.currentState.reset();
                              newItem = new AlistItemTypeV2('', '');
                              // If the form is valid, we want to show a Snackbar
                              ScopedModel.of<ListsRepository>(context,
                                      rebuildOnChange: true)
                                  .updateAlist(widget.aList);
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ])),
        ]);
  }
}
