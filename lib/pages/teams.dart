import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Teams",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: [
          IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () {
              //sign out the user
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              size: 20,
              color: Colors.black,
            ),
          ),
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
                  title: "Team 1",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 2",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 3",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 4",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 5",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 6",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 7",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 8",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 9",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 10",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 11",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 12",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 13",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 14",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 15",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 16",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 17",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 18",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 19",
                  subtitle: "10",
                ),
                teamsCard(
                  title: "Team 20",
                  subtitle: "10",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
