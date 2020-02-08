import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class AutoInputInferface {
  final String label;

  AutoInputInferface(this.label);
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'AutoFront';

  @override
  Widget build(BuildContext context) {
    const teste = 'lorem';

    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              TextWidget(),
              InputWidgetState(autoInput: new AutoInputInferface("Lorem")),
              InputWidgetState(autoInput: new AutoInputInferface("Ipsum"))
            ]),
      ),
    );
  }
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
