import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:test1/model/number.dart';
import 'package:test1/data/number_api.dart';



class NumberList extends StatefulWidget {
  NumberList({Key? key}) : super(key: key);

  @override
  _NumberListState createState() => _NumberListState();
}

class _NumberListState extends State<NumberList> {
    List<Number> numberList = <Number>[];

  void getNumbersfromApi() async {
    NumberApi.getNumbers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        numberList = list.map((model) => Number.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNumbersfromApi();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Random number"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {


                    });
                  }, child: const Text(' Get new random number'),
              ),
              Container(
              height: 500,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: ListView.builder(
                    itemCount: numberList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(numberList[index].random.toString()),
                      );
                    }),
              )
            ],

          ));
    }
}