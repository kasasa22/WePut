// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_user.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login_register');
  }

  void fetchNotificationsForCurrentUser() async {
    // Step 1: Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      print(
          'User Email-------------------------------------------------------------------------------------------------------------------------------------------------: $userEmail');

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

  // Replace with your method to get the currently logged-in user's ID
  String getCurrentUserId() {
    Map<String, dynamic> userData = getCurrentUserData();

    return userData['email']; // Use square brackets to access the value
  }

  String email = "";
  late String name = "";

  @override
  void initState() {
    fetchNotificationsForCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = getCurrentUserId();
    name = name;

    // User name found
    print("User Name: ---------");
    print(name);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/drawer.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 14),
                    child: Icon(
                      Icons.task_alt_outlined,
                      size: 90,
                      color: Colors.black,
                      weight: 50,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 5,
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[800],
              ),
              title: Text("H O M E",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the home page
                Navigator.pushNamed(context, '/home');
              },
            ),

            // dashboard tile
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.grey[800],
              ),
              title: Text("D A S H B O A R D",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the dashboard page
                Navigator.pushNamed(context, '/dashboard');
              },
            ),

            // teams tile
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.grey[800],
              ),
              title: Text("T E A M S",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the teams page
                Navigator.pushNamed(context, '/teams');
              },
            ),

            // Tasks tile
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.grey[800],
              ),
              title: Text("T A S K S",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                Navigator.pushNamed(context, '/tasks');
              },
            ),

            // Inbox tile
            ListTile(
              leading: Icon(
                Icons.inbox,
                color: Colors.grey[800],
              ),
              title: Text("N O T I F I C A T I O N S",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the inbox page
                Navigator.pushNamed(context, '/inbox');
              },
            ),

            // timeline tile
            ListTile(
              leading: Icon(
                Icons.timeline,
                color: Colors.grey[800],
              ),
              title: Text("T I M E L I N E",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the timeline page
                Navigator.pushNamed(context, '/timeline');
              },
            ),

            // profile tile
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.grey[800],
              ),
              title: Text("P R O F I L E",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the profile page
                Navigator.pushNamed(context, '/profile');
              },
            ),

            // settings tile
            // ListTile(
            //   leading: Icon(
            //     Icons.settings,
            //     color: Colors.grey[800],
            //   ),
            //   title: Text("S E T T I N G S",
            //       style: Theme.of(context).textTheme.titleSmall),
            //   onTap: () {
            //     //pop drawer
            //     Navigator.pop(context);

            //     //navigate to the settings page
            //     Navigator.pushNamed(context, '/settings');
            //   },
            // ),

            // profile tile
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.grey[800],
              ),
              title: Text("A B O U T",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the profile page
                Navigator.pushNamed(context, '/about');
              },
            ),

            // logout tile
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey[800],
              ),
              title: Text("L O G O U T",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
