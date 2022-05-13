import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test1/LogoutPage.dart';

class LoginPage extends StatelessWidget {
  static final googleLogin = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            print('押した');
            final GoogleSignInAccount? signinAccount =
                await googleLogin.signIn();
            if (signinAccount == null) {
              print('NULL');
              return;
            }
            print('auth');
            GoogleSignInAuthentication auth =
                await signinAccount.authentication;
            print('credential');
            final OAuthCredential credential = GoogleAuthProvider.credential(
              idToken: auth.idToken,
              accessToken: auth.accessToken,
            );
            print('user');
            User? user =
                (await FirebaseAuth.instance.signInWithCredential(credential))
                    .user;
            if (user != null) {
              print('ユーザーあり');
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LogoutPage(user);
                }),
              );
            } else {
              print('ユーザーなし');
            }
          },
          child: Text(
            'login',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
