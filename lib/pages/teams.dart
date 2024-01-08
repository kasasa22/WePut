import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/components/teams/teams_card.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("blue"),
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "My Teams",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("32 Teams are added"),
                  ],
                ),
                Icon(
                  Icons.add_circle_outline_outlined,
                  size: 30,
                  color: Colors.lightGreen,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: const [
                teamsCard(
                  title: "The Testers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "The Developers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "The Designers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "The Testers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "The Developers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "The Designers",
                  subtitle: "230",
                ),
                teamsCard(
                  title: "title",
                  subtitle: "400",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
