import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? _controller;
  final imagePicker = ImagePicker();
  Future getVideoFromCamera() async {
    final pickedFile = await imagePicker.getVideo(source: ImageSource.camera);
    _controller = VideoPlayerController.file(File(pickedFile!.path));
    _controller!.initialize().then((_) {
      setState(() {
        _controller!.play();
      });
    });
  }

  Future getVideoFromGarally() async {
    PickedFile pickedFile =
        (await imagePicker.getVideo(source: ImageSource.gallery))!;
    _controller = VideoPlayerController.file(File(pickedFile.path));
    _controller!.initialize().then((_) {
      setState(() {
        _controller!.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Center(
            // ignore: unnecessary_null_comparison
            child: _controller == null
                ? Text(
                    '動画を選択してください',
                    style: Theme.of(context).textTheme.headline4,
                  )
                : VideoPlayer(_controller!)),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
              onPressed: getVideoFromCamera, child: Icon(Icons.video_call)),
          FloatingActionButton(
              onPressed: getVideoFromGarally, child: Icon(Icons.movie_creation))
        ]));
  }
}
