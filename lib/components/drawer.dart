import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
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
                      size: 70,
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
                          const Text(
                            "Hello Alan",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 5,
                          ),
                          const Text(
                            "ateraxantonio@gmail.com",
                            style: TextStyle(
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
              title: Text("I N B O X",
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
