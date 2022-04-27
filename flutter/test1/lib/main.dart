import 'package:flutter/material.dart';
import 'package:test1/dummy.dart';

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
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      print("call setState");
      _counter++;
    });
    nextpage();
  }

  // ダミーで画面遷移を行う
  void nextpage() async {
    {
      // ダミー画面へ遷移
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return DummyPage();
      }));
    }
  }

  @override
  void initState() {
    print("call initState");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("call didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("call build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              key: Key('counter'),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('increment'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    print("call didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("call deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("call dispose");
    super.dispose();
  }
}
