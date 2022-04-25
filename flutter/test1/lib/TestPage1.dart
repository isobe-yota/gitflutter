import 'package:flutter/material.dart';
import 'package:test1/TestPage2.dart';

class TestPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test1"),
        ),
        body: Center(
            child: TextButton(
                onPressed: () => {Navigator.of(context).pushNamed("/test2")},
                child: Text("進む", style: TextStyle(fontSize: 80)))));
  }
}
