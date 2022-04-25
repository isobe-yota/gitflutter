import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // テストケースをグループ化しておきますが、今回のように1ケースだとあまり意味はないです
  group('Counter App', () {
    // keyでWidgetを取得する
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');
    late FlutterDriver driver; // Dart2以降はNullsafetyのため lateで初期化を遅延させる

    // すべてのテストの前にDriverに接続する
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    // すべてのテストの後にDriverを開放する
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    // テスト1:開始時にTextが0であることを確認する
    test('starts at 0', () async {
      expect(await driver.getText(counterTextFinder), "0");
    });
    // テスト2:incrementをタップすると、Textが1になることを確認する
    test('increments the counter', () async {
      // タップ操作
      await driver.tap(buttonFinder);
      // Textの検証.
      expect(await driver.getText(counterTextFinder), "1");
    });
  });
}
