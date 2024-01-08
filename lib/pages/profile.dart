import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

import '../data/my_strings.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text("Profile"),
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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 35,
                ),
                Text("Alan Woods",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                        fontSize: 25)),
                Container(
                  height: 5,
                ),
                Text(
                  "Developer",
                  style: TextStyle(color: Colors.grey[60]),
                ),
                Container(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: const Icon(Icons.phone, color: Colors.green),
                      ),
                      onTap: () {},
                    ),
                    Container(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.green[600],
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/person.jpg"),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    InkWell(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: const Icon(Icons.message, color: Colors.green),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            const Text(
                              "1.5K",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 25),
                            ),
                            Container(height: 5),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            const Text(
                              "1.5K",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 25),
                            ),
                            Container(height: 5),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            const Text(
                              "1.5K",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 25),
                            ),
                            Container(height: 5),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        MyStrings.middle_lorem_ipsum,
                        textAlign: TextAlign.center,
                        selectionColor: Colors.grey[900],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
