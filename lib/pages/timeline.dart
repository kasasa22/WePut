import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Timeline"),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
              PopupMenuItem(
                value: "About",
                child: IconButton(
                  onPressed: () {
                    //sign out the user
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),

      //Drawer
      drawer: const MyDrawer(),

      //Body
      body: const Center(
        child: Text("Timeline Page"),
      ),
    );
  }
}
