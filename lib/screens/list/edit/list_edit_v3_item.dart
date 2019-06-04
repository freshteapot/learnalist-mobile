import 'package:flutter/material.dart';
import 'package:learnalist/models/alist.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';

// Create a Form Widget
class ListEditItemV3Screen extends StatelessWidget {
  final AlistV3 aList;

  ListEditItemV3Screen({Key key, @required this.aList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          ListItemV3Form(aList),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class ListItemV3Form extends StatefulWidget {
  final AlistV3 aList;

  ListItemV3Form(this.aList);

  @override
  ListItemV3FormState createState() {
    return ListItemV3FormState();
  }
}

class ListItemV3FormState extends State<ListItemV3Form> {
  final _formKey = GlobalKey<FormState>();
  TypeV3Item _newItem;
  FocusNode _firstFocus;

  @override
  void initState() {
    super.initState();

    _firstFocus = FocusNode();
    _newItem =
        new TypeV3Item('', new V3Split('', 0, 0, ''), new List<V3Split>());
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _firstFocus.dispose();

    super.dispose();
  }

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
                        focusNode: _firstFocus,
                        autofocus: true,
                        autocorrect: false,
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'When:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.when = value;
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Time:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the time it took.';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.overall.time = value;
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Distance:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the distance.';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.overall.distance = int.parse(value);
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Stroke per minute:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the strokes per minute.';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.overall.spm = int.parse(value);
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: '500m split time:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the 500m split time.';
                          }
                        },
                        onSaved: (String value) {
                          _newItem.overall.p500 = value;
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _formKey.currentState.reset();
                            _newItem = new TypeV3Item('',
                                new V3Split('', 0, 0, ''), new List<V3Split>());
                            FocusScope.of(context).requestFocus(_firstFocus);
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              widget.aList.addItem(_newItem);

                              _formKey.currentState.reset();
                              _newItem = new TypeV3Item(
                                  '',
                                  new V3Split('', 0, 0, ''),
                                  new List<V3Split>());
                              FocusScope.of(context).requestFocus(_firstFocus);
                              // If the form is valid, we want to show a Snackbar
                              ScopedModel.of<ListsRepository>(context)
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
