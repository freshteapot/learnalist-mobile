import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListEditItemV1Screen extends StatelessWidget {
  final AlistV1 aList;

  ListEditItemV1Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          V1ListItemV1Form2(aList),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class V1ListItemV1Form2 extends StatefulWidget {
  final Alist aList;

  V1ListItemV1Form2(this.aList);

  @override
  V1ListItemV1Form2State createState() {
    return V1ListItemV1Form2State();
  }
}

class V1ListItemV1Form2State extends State<V1ListItemV1Form2> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          widget.aList.listData.add(value);
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _formKey.currentState.reset();
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
