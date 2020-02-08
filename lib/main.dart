import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  runApp(MyApp(autoInput: new AutoInputInferface(_data[0]['title'])));
}

class AutoInputInferface {
  final String label;

  AutoInputInferface(this.label);
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'AutoFront';
  final AutoInputInferface autoInput;
  MyApp({Key key, @required this.autoInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenArray = [];
    // const List<Widget> childrenArray = [
    //           new TextWidget(),
    //           InputWidgetState(autoInput: new AutoInputInferface("Lorem")),
    //           InputWidgetState(autoInput: new AutoInputInferface("Ipsum"))
    //         ];
    const li = [1, 2, 3];

    for (final e in li) {
      childrenArray.add(TextWidget());
      childrenArray.add(InputWidgetState(
          autoInput: new AutoInputInferface("${autoInput.label}")));
    }

    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: childrenArray),
      ),
    );
  }
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body); // return a List Type
}

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text('Hello World'));
  }
}

class ButtonWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          // Validate will return true if the form is valid, or false if
          // the form is invalid.
          if (_formKey.currentState.validate()) {
            // Process data.
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}

class InputWidgetState extends StatelessWidget {
  final AutoInputInferface autoInput;

  // In the constructor, require a Person
  InputWidgetState({Key key, @required this.autoInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: autoInput.label,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
