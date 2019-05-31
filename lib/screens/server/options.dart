import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnalist/models/lists_repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/models/server_credentials.dart';

class ServerOptionsScreen extends StatelessWidget {
  ServerOptionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Server Options"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          ServerOptionsForm(),
        ]),
      ),
    );
  }
}

// Create a Form Widget
class ServerOptionsForm extends StatefulWidget {
  ServerOptionsForm();

  @override
  ServerOptionsFormState createState() {
    return ServerOptionsFormState();
  }
}

class ServerOptionsFormState extends State<ServerOptionsForm> {
  final _formKey = GlobalKey<FormState>();
  ServerCredentialsInput _input;
  FocusNode _firstFocus;

  @override
  void initState() {
    super.initState();

    _firstFocus = FocusNode();
    // Load from db here.
    var credentials = ScopedModel.of<ListsRepository>(context).credentials;
    var server = credentials.getServer();
    var username = credentials.getUsername();
    _input = new ServerCredentialsInput(server: server, username: username);
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
                        initialValue: _input.server,
                        decoration: InputDecoration(
                            labelText: 'Server:', hintText: SERVER_HINT),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the server and the path to the api';
                          }
                        },
                        onSaved: (String value) {
                          _input.server = value;
                        }),
                    TextFormField(
                        initialValue: _input.username,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Username:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your username';
                          }
                        },
                        onSaved: (String value) {
                          _input.username = value;
                        }),
                    TextFormField(
                        initialValue: '',
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Password:',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                        },
                        obscureText: true,
                        onSaved: (String value) {
                          _input.password = value;
                        }),
                    ButtonBar(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            _formKey.currentState.reset();
                            _input = new ServerCredentialsInput(
                                server: SERVER_HINT,
                                username: '',
                                password: '');
                            FocusScope.of(context).requestFocus(_firstFocus);
                            // TODO - we should have a way to remove the credentials
                            await ScopedModel.of<ListsRepository>(context)
                                .credentials
                                .clear();
                          },
                          child: Text('Reset'),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // TODO

                              var credentials = ServerCredentials(
                                  server: _input.server,
                                  username: _input.username,
                                  basicAuth: _input.getBasicAuth());

                              _input = new ServerCredentialsInput();
                              print('Save this somewhere');
                              print(credentials);
                              print(credentials.basicAuth);
                              var success =
                                  await ScopedModel.of<ListsRepository>(context)
                                      .saveCredentials(credentials);
                              print("Did the save work?");
                              print(success);
                            }
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ])),
        ]);
  }
}
