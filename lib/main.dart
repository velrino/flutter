import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AutoFront',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return createListView(context, snapshot);
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<String>> _getData() async {
    var values = new List<String>();
    String apiUrl = 'http://www.mocky.io/v2/5e3e37ed33000052008b09ab';
    http.Response response = await http.get(apiUrl);
    final items = json.decode(response.body);

    for (var item in items['page_test']['body']['render']) {
      values.add(item['type']);
    }
    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    List<Widget> childrenArray = [];

    for (final value in values) {
      if (value == 'text') {
        childrenArray
            .add(TextWidget(autoInput: new AutoTextWidgetInferface(value)));
      } else if (value == 'input') {
        childrenArray
            .add(InputWidgetState(autoInput: new AutoInputInferface(value)));
      }
    }

    return new ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: childrenArray,
        );
      },
    );
  }
}

class TextWidget extends StatelessWidget {
  final AutoTextWidgetInferface autoInput;

  TextWidget({Key key, @required this.autoInput}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(this.autoInput.label));
  }
}

class AutoTextWidgetInferface {
  final String label;

  AutoTextWidgetInferface(this.label);
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

class AutoInputInferface {
  final String label;

  AutoInputInferface(this.label);
}
