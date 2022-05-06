import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

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
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<double> accelerometerValues = <double>[];
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stete = $state");
    switch (state) {
      case AppLifecycleState.inactive:
        print('非アクティブになったときの処理');
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        break;
      case AppLifecycleState.detached:
        print('破棄されたときの処理');
        break;
    }
  }

  int _counter = 0;
  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer = accelerometerValues
        .map((double v) => v.toStringAsFixed(1))
        .toList() as List<String>;
    final double accel_x = accelerometerValues[0];
    final String accel_y = accelerometerValues[1].toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Accelerometer: $accelerometer',
            ),
            Text('ACCEL_X: $accel_x'),
            Text("ACCEL_Y: $accel_y"),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
