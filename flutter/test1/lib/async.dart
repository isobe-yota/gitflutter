import 'dart:async';
import 'dart:io';

class Async {
  void asynctest3() async {
    print("method begin");
    print(DateTime.now().toString());
    print("data1 start");
    Future<String> result1 = asyncFunc("data1", 3);
    result1.then((result) {
      print(result);
    });
    print("data2 start");
    Future<String> result2 = asyncFunc("data2", 2);
    result2.then((result) {
      print(result);
    });
    print("data3 start");
    Future<String> result3 = asyncFunc("data3", 1);
    result3.then((result) {
      print(result);
    });
  }

  // timeの時間分スリープし、その後現在時間を返す関数
  Future<String> asyncFunc(String name, int time) async {
    return Future.delayed(Duration(seconds: time), () {
      return name + ":" + DateTime.now().toString();
    });
  }
}
