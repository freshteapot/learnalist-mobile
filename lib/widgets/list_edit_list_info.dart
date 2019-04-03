import 'package:flutter/material.dart';
import 'package:learnalist/models/learnalist.dart';

class EditListInfo extends StatefulWidget {
  const EditListInfo({
    @required this.aList,
    this.onSaved,
  });

  final Alist aList;
  final Function onSaved;

  @override
  State<StatefulWidget> createState() => EditListInfoState();
}

class EditListInfoState extends State<EditListInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        initialValue: widget.aList.listInfo.title,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        onSaved: widget.onSaved,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                    )),
                Text(
                  widget.aList.uuid,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
