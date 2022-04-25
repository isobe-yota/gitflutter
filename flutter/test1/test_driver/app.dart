import 'package:flutter_driver/driver_extension.dart';
import 'package:test1/main.dart' as app;

void main() {
  // 別プロセスのアプリケーションを起動できるようにするために拡張を有効にする
  enableFlutterDriverExtension();
  // アプリの起動
  app.main();
}
