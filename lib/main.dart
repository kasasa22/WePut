import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maker/auth/auth.dart';
import 'package:maker/auth/login_or_register.dart';
import 'package:maker/firebase_options.dart';
import 'package:maker/pages/boards.dart';
import 'package:maker/pages/dashboard.dart';
import 'package:maker/pages/home_page.dart';
import 'package:maker/pages/inbox.dart';
import 'package:maker/pages/profile.dart';
import 'package:maker/pages/settings.dart';
import 'package:maker/pages/teams.dart';
import 'package:maker/pages/timeline.dart';
import 'package:maker/theme/dark_mode.dart';
import 'package:maker/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register': (context) => const LoginOrRegister(),
        '/home': (context) => const HomePage(),
        '/teams': (context) => const Teams(),
        '/timeline': (context) => const Timeline(),
        '/inbox': (context) => const Inbox(),
        '/boards': (context) => const Boards(),
        '/dashboard': (context) => const Dashboard(),
        '/profile': (context) => const Profile(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
