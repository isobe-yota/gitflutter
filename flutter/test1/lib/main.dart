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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationControler;
  late Animation<double> _animationDouble;
  Tween<double> _tweenDouble = Tween(begin: 0.0, end: 200.0);
  late Animation<Color?> _animationColor;
  ColorTween _tweenColor = ColorTween(begin: Colors.green, end: Colors.blue);

  _play() async {
    setState(() {
      _animationControler.forward();
    });
  }

  _stop() async {
    setState(() {
      _animationControler.stop();
    });
  }

  _reverse() async {
    setState(() {
      _animationControler.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationControler =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animationDouble = _tweenDouble.animate(_animationControler);
    _animationDouble.addListener(() {
      setState(() {});
    });
    _animationColor = _tweenColor.animate(_animationControler);
    _animationColor.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationControler.dispose();
    super.dispose();
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
            Text("AnimationController:${_animationControler.value}"),
            Text("AnimationDouble:${_animationDouble.value}"),
            Text("AnimationColor:${_animationColor.value}"),
            SizeTransition(
              sizeFactor: _animationControler,
              child: Center(
                  child: SizedBox(
                      width: _animationDouble.value,
                      height: _animationDouble.value,
                      child: Container(color: _animationColor.value))),
            ),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            onPressed: _play, child: Icon(Icons.arrow_forward)),
        FloatingActionButton(onPressed: _stop, child: Icon(Icons.pause)),
        FloatingActionButton(
            onPressed: _reverse, child: Icon(Icons.arrow_back)),
      ]),
    );
  }
}
