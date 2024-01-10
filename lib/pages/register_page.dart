// ignore_for_file: use_build_context_synchronously, library_prefixes, avoid_print, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';
import 'package:maker/components/my_button.dart';
import 'package:maker/components/my_textfeild.dart';
import 'package:maker/models/user.dart' as dbUser;

import '../services/user.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final UserService _userService = UserService();

  void registerUser() async {
    // Show the loading indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if the passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // Hide the loading indicator
      Navigator.pop(context);

      // Show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Passwords do not match"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    } else {
      try {
        // Create the user in Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Print user UID for testing
        print("User ID: " + userCredential.user!.uid);

        // Create a user object
        dbUser.User newUser = dbUser.User(
          userId: userCredential.user!.uid,
          name: usernameController.text,
          email: emailController.text,
          role: 'user',
          completedTasks: 0,
          averageCompletionTime: 0,
        );

        // Add the user details to Firestore using UserService
        _userService.addUser(newUser);

        // Hide the loading indicator
        Navigator.pop(context);
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        // Hide the loading indicator
        Navigator.pop(context);

        // Show the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo
              const Icon(
                Icons.task_alt,
                size: 50,
                color: Colors.green,
              ),

              //app name
              Text('W E P U T',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),

              const SizedBox(height: 20),
              //username textfield
              MyTextFeild(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 8),
              //email textfield
              MyTextFeild(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 8),
              //password textfield
              MyTextFeild(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 8),
              //confirm password textfield
              MyTextFeild(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 8),
              //Register button
              MyButton(
                text: 'Register',
                onTap: registerUser,
              ),

              //have an account, sign in here
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Login Here",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
