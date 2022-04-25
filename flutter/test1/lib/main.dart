import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool flag = false;
  _click() async {
    setState(() {
      flag = !flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
                duration: Duration(seconds: 3),
                width: flag ? 100 : 50,
                height: flag ? 50 : 100,
                padding: flag ? EdgeInsets.all(0) : EdgeInsets.all(30),
                margin: flag ? EdgeInsets.all(0) : EdgeInsets.all(30),
                transform: flag ? Matrix4.skewX(0.0) : Matrix4.skewX(0.3),
                color: flag ? Colors.blue : Colors.grey),
            AnimatedSwitcher(
                duration: Duration(seconds: 3),
                child: flag
                    ? Text("なにもない")
                    : Icon(Icons.favorite, color: Colors.pink))
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(onPressed: _click, child: Icon(Icons.add)),
      ]),
    );
  }
}
