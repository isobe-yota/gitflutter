import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/login': (_) => new Login(),
      },
    );
  }
}

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   //ステップ１
//   final _auth = FirebaseAuth.instance;

//   String email = '';
//   String password = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('新規登録'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: (value) {
//                 email = value;
//               },
//               decoration: const InputDecoration(
//                 hintText: 'メールアドレスを入力',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: (value) {
//                 password = value;
//               },
//               obscureText: true,
//               decoration: const InputDecoration(
//                 hintText: 'パスワードを入力',
//               ),
//             ),
//           ),
//           ElevatedButton(
//             child: const Text('新規登録'),
//             //ステップ２
//             onPressed: () async {
//               try {
//                 final newUser = await _auth.createUserWithEmailAndPassword(
//                     email: email, password: password);
//                 if (newUser != null) {
//                   Navigator.pushNamed(context, '/content');
//                 }
//               } on FirebaseAuthException catch (e) {
//                 if (e.code == 'email-already-in-use') {
//                   print('指定したメールアドレスは登録済みです');
//                 } else if (e.code == 'invalid-email') {
//                   print('メールアドレスのフォーマットが正しくありません');
//                 } else if (e.code == 'operation-not-allowed') {
//                   print('指定したメールアドレス・パスワードは現在使用できません');
//                 } else if (e.code == 'weak-password') {
//                   print('パスワードは６文字以上にしてください');
//                 }
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// class MainContent extends StatefulWidget {
//   const MainContent({Key? key}) : super(key: key);

//   @override
//   _MainContentState createState() => _MainContentState();
// }

// class _MainContentState extends State<MainContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('成功'),
//       ),
//       body: Center(
//         child: Text('新規登録成功！'),
//       ),
//     );
//   }
// }
