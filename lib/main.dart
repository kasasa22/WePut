import 'package:cloud_firestore/cloud_firestore.dart'
    as firebase; // Use 'firebase' as a prefix
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maker/auth/auth.dart';
import 'package:maker/auth/login_or_register.dart';
import 'package:maker/firebase_options.dart';
import 'package:maker/pages/boards.dart';
import 'package:maker/pages/crud_test.dart';
import 'package:maker/pages/dashboard.dart';
import 'package:maker/pages/home_page.dart';
import 'package:maker/pages/inbox.dart';
import 'package:maker/pages/profile.dart';
import 'package:maker/pages/settings.dart'
    // ignore: library_prefixes
    as mySettings; // Use 'mySettings' as a prefix
import 'package:maker/pages/teams.dart';
import 'package:maker/pages/timeline.dart';
import 'package:maker/theme/dark_mode.dart';
import 'package:maker/theme/light_mode.dart';

import 'pages/about_us.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  firebase.FirebaseFirestore.instance.settings =
      const firebase.Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode.copyWith(
        primaryColor: Colors.green,
      ),
      darkTheme: darkMode,
      themeMode: ThemeMode.light,
      routes: {
        '/login_register': (context) => const LoginOrRegister(),
        '/home': (context) => const HomePage(),
        '/teams': (context) => const Teams(),
        '/timeline': (context) => const Timeline(),
        '/inbox': (context) => const Inbox(),
        '/boards': (context) => const Boards(),
        '/test': (context) => const Test(),
        '/dashboard': (context) => const Dashboard(),
        '/profile': (context) => const Profile(),
        'about': (context) => const About(),
        '/settings': (context) =>
            const mySettings.Settings(), // Use 'mySettings' prefix
      },
    );
  }
}
