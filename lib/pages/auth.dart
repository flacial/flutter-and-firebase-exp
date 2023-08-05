import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/pages/login.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseAuth.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const Text('Home page');
        }

        return const LoginPage();
      }),
    );
  }
}
