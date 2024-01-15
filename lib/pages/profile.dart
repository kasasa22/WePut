// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    fetchForCurrentUser();
    super.initState();
  }

  void fetchForCurrentUser() async {
    // Step 1: Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      setState(() {
        email = userEmail;
      });

      print('User Email-----------------------: $userEmail');

      // Step 2: Query the users collection to get the user's document ID
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming there is only one document for a unique email
        String userId = userQuery.docs.first.id;

        // Step 5: Use the obtained userId to query the user's document and get the name
        DocumentSnapshot userDocument = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDocument.exists) {
          String userName = userDocument['name'];
          print('User Name: $userName');
          setState(() {
            name = userName;
          });
          name = userName;
        } else {
          print('User document not found.');
        }
      } else {
        print('User not found.');
      }
    } else {
      print('User not authenticated.');
    }
  }

  late String name = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
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
        child: Column(
          children: [
            Container(
              height: 25,
            ),
            Text(name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 25)),
            Container(
              height: 5,
            ),
            Text(
              email,
              style: TextStyle(color: Colors.blue[60]),
            ),
            Container(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(Icons.phone, color: Colors.blue),
                  ),
                  onTap: () {},
                ),
                Container(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.blue[600],
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/person.jpg"),
                  ),
                ),
                Container(
                  width: 10,
                ),
                InkWell(
                  child: const SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(Icons.message, color: Colors.blue),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Container(height: 50),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    const Text(
                      "20",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Container(height: 5),
                    const Text(
                      "Assignments",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    const Text(
                      "5",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Container(height: 5),
                    const Text(
                      "Teams",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    const Text(
                      "17",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Container(height: 5),
                    const Text(
                      "Projects",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ]),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Hi there! I'm $name, an enthusiastic Banker based in Uganda. I love Games and Coding and believe in making every moment count. Whether it's exploring new ideas or enjoying some downtime with a good book, I cherish the simple joys of life. Join me on this journey, and let's create some wonderful memories together!",
                textAlign: TextAlign.center,
                selectionColor: Colors.blue[900],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "",
                textAlign: TextAlign.center,
                selectionColor: Colors.blue[900],
              ),
            ),
            Container(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    Text(
                      "Phone",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                          fontSize: 25),
                    ),
                    Container(height: 5),
                    const Text(
                      "(+256) 708737653",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                          fontSize: 25),
                    ),
                    Container(height: 5),
                    const Text(
                      "Kampala, Uganda",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                          fontSize: 25),
                    ),
                    Container(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    Text(
                      "Website",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                          fontSize: 25),
                    ),
                    Container(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
