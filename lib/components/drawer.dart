import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            //drawer header
            DrawerHeader(
              child: Icon(
                Icons.task_alt,
                size: 100,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 2),
            // home tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.green[400],
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
            ),
            const SizedBox(height: 2),
            // dashboard tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.green[400],
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
            ),

            const SizedBox(height: 2),
            // teams tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.green[400],
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
            ),

            const SizedBox(height: 2),
            // Boards tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.green[400],
                ),
                title: Text("B O A R D S",
                    style: Theme.of(context).textTheme.titleSmall),
                onTap: () {
                  //pop drawer
                  Navigator.pop(context);

                  //navigate to the boards page
                  Navigator.pushNamed(context, '/boards');
                },
              ),
            ),

            const SizedBox(height: 2),
            // Inbox tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: Colors.green[400],
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
            ),

            const SizedBox(height: 2),
            // timeline tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.timeline,
                  color: Colors.green[400],
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
            ),

            const SizedBox(height: 2),
            // settings tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.green[400],
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
            ),

            const SizedBox(height: 2),
            // profile tile
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.green[400],
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
            ),
          ],
        ),

        // logout tile
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 25,
          ),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.green[400],
            ),
            title: Text("L O G O U T",
                style: Theme.of(context).textTheme.titleSmall),
            onTap: () {
              //pop drawer
              Navigator.pop(context);

              //logout the user
              logout();
            },
          ),
        ),
      ]),
    );
  }
}
