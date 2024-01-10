import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/models/assignment.dart';
import 'package:maker/services/assignment.dart';

// ignore: must_be_immutable
class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<Assignment> listAssignments = [];

  @override
  void initState() {
    fetchTeams();
    super.initState();
  }

  Future<void> fetchTeams() async {
    AssignmentService taskService = AssignmentService();
    taskService.getAssignments().listen((QuerySnapshot snapshot) {
      // Clear existing lists
      listAssignments.clear();

      for (var document in snapshot.docs) {
        Assignment assignment =
            Assignment.fromJson(document.data() as Map<String, dynamic>);

        // Add the fetched assignment to the list
        listAssignments.add(assignment);
      }

      // Use setState to trigger a rebuild with the updated lists
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gridAssignments = getGridViewAssignments(listAssignments);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Teams"),
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

      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  "https://images.unsplash.com/photo-1532499012374-fdfae50e73e9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZnVybml0dXJlc3xlbnwwfDF8MHxibGFja3w%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                height: 200,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Teams",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Here are the Teams that you are part of\n you can browse through",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            transform: Matrix4.translationValues(0.0, -30, 0.0),
            child: Column(
              children: gridAssignments,
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> getGridViewAssignments(List<Assignment> lc) {
    List<Widget> wc = [];

    for (int i = 0; i < (lc.length / 2).ceil(); i++) {
      Widget w;

      if ((i * 2) + 1 < lc.length) {
        // If there are two assignments available
        w = Row(
          children: [
            getItemViewGrid(lc[i * 2]),
            Container(width: 2),
            getItemViewGrid(lc[(i * 2) + 1]),
          ],
        );
      } else {
        // If there is only one assignment available
        w = Row(
          children: [
            getItemViewGrid(lc[i * 2]),
          ],
        );
      }

      wc.add(w);
    }

    return wc;
  }

  Widget getItemViewGrid(Assignment s) {
    return Expanded(
        flex: 1,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.white,
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            alignment: Alignment.center,
            height: 120,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.task,
                      size: 40,
                      color: Colors.blue[600],
                    ),
                  ),
                  Text(
                    s.completionStatus,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  )
                ]),
          ),
        ));
  }
}
