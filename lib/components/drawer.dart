// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/services/user.dart';

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

  // Replace with your method to get the currently logged-in user's ID
  String getCurrentUserId() {
    Map<String, dynamic> userData = getCurrentUserData();

    return userData['email']; // Use square brackets to access the value
  }

  String email = "";

  late String? userName = "";

  @override
  void initState() {
    super.initState();
    // Call the asynchronous method to fetch user data
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    email = getCurrentUserId();
    UserService _userService = UserService();

    // Example usage to get a user's name by email
    String userEmail = email;
    userName = (await _userService.getUserNameByEmail(userEmail));

    // User name found
    print("User Name: $userName");

    // Ensure the widget is rebuilt after fetching data
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    email = getCurrentUserId();

    // User name found
    print("User Name: $userName");
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
                            userName ?? 'Welcome User',
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
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[800],
              ),
              title: Text("S E T T I N G S",
                  style: Theme.of(context).textTheme.titleSmall),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                //navigate to the settings page
                Navigator.pushNamed(context, '/settings');
              },
            ),

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
