import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

// [Themelist] インスタンスにおける処理。
class Home extends StatelessWidget {
  final String? user_id;
  final FirebaseAuth? auth;

  Home({Key? key, this.user_id, this.auth}) : super(key: key);

  // 前画面から受け取った値はNull許容のため、入れ直し用の変数を用意
  late String _user_id;
  @override
  Widget build(BuildContext context) {
    _user_id = user_id ?? 'ログインユーザー名取得失敗';
    const List<String> _popmenu_list = ["テストアプリ", "ログアウト"];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("testhome"),
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0.0,

        // 右上メニューボタン
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: (String s) {
              if (s == 'ログアウト') {
                auth?.signOut();
                Navigator.of(context).pushNamed("/login");
              }
            },
            itemBuilder: (BuildContext context) {
              return _popmenu_list.map((String s) {
                return PopupMenuItem(
                  child: Text(s),
                  value: s,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
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

    const List<String> _popmenu_list = ["テストアプリ", "ログアウト"];

    return Scaffold(
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
