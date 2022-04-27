import 'dart:async';
import 'dart:io';

class Async {
  void asynctest1() {
    print("method begin");
    print(DateTime.now().toString());
    print("data1 start");
    print(syncFunc("data1", 3));
    print("data2 start");
    print(syncFunc("data2", 2));
    print("data3 start");
    print(syncFunc("data3", 1));
  }

  // timeの時間分スリープし、その後現在時間を返す関数
  String syncFunc(String name, int time) {
    sleep(Duration(seconds: time));
    return name + ":" + DateTime.now().toString();
  }
}
