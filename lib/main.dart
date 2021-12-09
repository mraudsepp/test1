import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Random number generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Number>> _getNumbers() async {
    http.Response response = await http.get(Uri.parse("https://csrng.net/csrng/csrng.php?min=1&max=100"));

    var jsonData = json.decode(response.body);

    List<Number> numbers = [];

    for (var number in jsonData["result"]) {
      Number newNumber = Number(number["status"], number["min"], number["max"],
          number["random"]);
      numbers.add(newNumber);
    }

    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: FutureBuilder(
            future: _getNumbers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int index) {
                    return Text(snapshot.data!.random);
                  },
                );
              }
            },
          ),
        ));
  }
}

class Number {
  final String status;
  final String min;
  final String  max;
  final String  random;

  Number(this.status, this.min, this.max, this.random);
}
