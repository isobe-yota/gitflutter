import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test1/LoginPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
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
  int _roopcount = 0;

  _incrementCounter(bool flag) {
    if (flag) {
      _roopcount = 1;
    } else {
      if (_roopcount == 1) {
        setState(() {
          _counter++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double accel = accelerometerValues[0] +
        accelerometerValues[1] +
        accelerometerValues[2];

    if (accel > 20.0) {
      _incrementCounter(true);
    } else if (accel < 5.0) {
      _incrementCounter(false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("ACCEL: $accel"),
            Text(
              '歩いた歩数',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
