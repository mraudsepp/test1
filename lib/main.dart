import 'package:test1/screens/numbers_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Random number generator App",
      theme: ThemeData(primarySwatch: Colors.grey),
      home: NumberList(),
    );
  }
}