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
