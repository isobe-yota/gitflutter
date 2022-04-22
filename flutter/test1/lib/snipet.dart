import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

//データの保存
saveFlag(bool flag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('FLAG', flag);
}

loadFlag() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('FLAG') ?? false;
}

// class MyTestApp {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: IconButton(
//             icon: Icon(Icons.open_in_browser),
//             onPressed: () async {
//               String url = Uri.encodeFull("https://www.google.co.jp");
//               if (await canLaunch(url)) {
//                 await launch(url);
//               }
//             }),
//       ),
//     );
//   }
// }

void func(String? param1, [int param2 = 0]) {
  var result = '$param1 / $param2';
  print(result);
}

void main() {
  func("pattern3");
}

class List {
  void add(int num) {}
}

// カスケード記法なし
var list1 = new List();

// list1.add(1);
// list1.add(2);

// カスケード記法あり
var list2 = new List()
  ..add(1)
  ..add(2);
