import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';
import 'package:maker/auth/login_or_register.dart';
import 'package:maker/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //check if the user is logged in
        if (snapshot.hasData) {
          //user is logged in
          return const HomePage();
        } else {
          //user is not logged in
          return const LoginOrRegister();
        }
      },
    ));
  }
}
