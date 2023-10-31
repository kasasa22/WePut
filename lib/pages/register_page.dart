import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';
import 'package:maker/components/my_button.dart';
import 'package:maker/components/my_textfeild.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({
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

  void registerUser() async {
    //show the loading indicator
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    //check if the passwords match
    if (passwordController.text != confirmPasswordController.text) {
      //hide the loading indicator
      Navigator.pop(context);

      //show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Passwords do not match"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    } else {
      //try to register the user
      try {
        //create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        //pop loading indicator
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading indicator
        Navigator.pop(context);

        //show the error message
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //logo
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            //app name
            Text('M A K E R',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),

            const SizedBox(height: 50),
            //username textfield
            MyTextFeild(
              hintText: "Username",
              obscureText: false,
              controller: usernameController,
            ),
            const SizedBox(height: 20),
            //email textfield
            MyTextFeild(
              hintText: "Email",
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(height: 10),
            //password textfield
            MyTextFeild(
              hintText: "Password",
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            //confirm password textfield
            MyTextFeild(
              hintText: "Confirm Password",
              obscureText: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 20),
            //Register button
            MyButton(
              text: 'Register',
              onTap: registerUser,
            ),

            //have an account, sign in here
            const SizedBox(height: 20),
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
    );
  }
}
