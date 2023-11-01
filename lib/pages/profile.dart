import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              //sign out the user
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      //Drawer
      drawer: const MyDrawer(),

      //Body
      body: const Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
