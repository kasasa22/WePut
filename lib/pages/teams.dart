// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

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
  AssignmentService taskService = AssignmentService();
  late List<Assignment> listAssignments = [
    // Assignment(
    //   teamName: "Teams",
    //   userId: "Teams",
    //   taskId: "TeamsTask",
    //   completionStatus: "Completed",
    //   assignmentTime: Timestamp.now(),
    // )
  ];

  late List<Assignment> listAssignmentsNew = [
    // Assignment(
    //   teamName: "Teams",
    //   userId: "Teams",
    //   taskId: "TeamsTask",
    //   completionStatus: "Completed",
    //   assignmentTime: Timestamp.now(),
    // )
  ];

  @override
  void initState() {
    fetchTeams();

    super.initState();
  }

  void fetchTeams() {
    taskService.getAssignments().listen((QuerySnapshot snapshot) {
      // Clear existing lists
      // listAssignments.clear();

      for (var document in snapshot.docs) {
        // print(
        //     "-------------------------------------------------------------------------------------------------------");
        // print(document["teamName"]);
        // print(document["userId"]);
        // print(document["taskId"]);
        // print(document["completionStatus"]);
        // print(document["assignmentTime"]);
        // print(
        //     "----------------------------------------------------------------------------------------");
        Assignment assignment = Assignment(
            teamName: document["teamName"],
            userId: document["userId"],
            taskId: document["taskId"],
            assignmentTime: document["assignmentTime"],
            completionStatus: document["completionStatus"]);
        listAssignments.add(assignment);
      }

      // Print the assignments for debugging
      for (var assignment in listAssignments) {
        print('Assignment: $assignment');
      }

      // Print the length of the list
      print('Number of assignments: ${listAssignments.length}');

      filterList();

      // Use setState to trigger a rebuild with the updated lists
      setState(() {});
    });
  }

  void filterList() {
    listAssignmentsNew.clear();
    Set<String> uniqueTeamNames = <String>{};

    print(listAssignments);

    for (var assignmentNew in listAssignments) {
      print(
          "----------------------------------------------------------------------------------nehre");
      String teamName = assignmentNew.teamName;
      if (!uniqueTeamNames.contains(teamName)) {
        uniqueTeamNames.add(teamName);

        String completionStatus = listAssignments
            .firstWhere(
              (a) => a.teamName == teamName,
            )
            .completionStatus;

        Assignment assignment = Assignment(
          teamName: teamName,
          userId: "USERS",
          taskId: "TASKS",
          assignmentTime: assignmentNew.assignmentTime,
          completionStatus: completionStatus,
        );

        listAssignmentsNew.add(assignment);

        print(
            "----------------------------------------------------------------------------------");

        print(listAssignmentsNew);
      }
    }

    // Now listAssignmentsNew contains unique team names with combined completion statuses
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (listAssignmentsNew.isEmpty) {
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

        body: const Center(
          child: Text("No assignments available"),
        ),
      );
    }
    List<Widget> gridAssignments = getGridViewAssignments(listAssignmentsNew);

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
                      Icons.people_alt_sharp,
                      size: 20,
                      color: Colors.blue[600],
                    ),
                  ),
                  Text(
                    s.teamName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Task Status:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        s.completionStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[100],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }
}
