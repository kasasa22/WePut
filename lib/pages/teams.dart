// ignore_for_file: avoid_print

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

  Map<String, int> teamCountMap = {};

  @override
  void initState() {
    fetchTeams();
    super.initState();
  }

  void fetchTeams() {
    taskService.getAssignments().listen((QuerySnapshot snapshot) {
      // Clear existing lists
      listAssignments.clear();

      for (var document in snapshot.docs) {
        print(
            "-------------------------------------------------------------------------------------------------------");
        print(document["teamName"]);
        print(document["userId"]);
        print(document["taskId"]);
        print(document["completionStatus"]);
        print(document["assignmentTime"]);
        print(
            "----------------------------------------------------------------------------------------");
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

      // Use setState to trigger a rebuild with the updated lists
      setState(() {});
    });
  }

  List<Map<String, dynamic>> processAssignments() {
    // Clear existing data
    teamCountMap.clear();
    int counter = 0;

    // Process assignments and update teamCountMap
    for (var assignment in listAssignments) {
      String teamName = assignment.teamName;

      if (teamCountMap.containsKey(teamName)) {
        // Increment count if team name already exists in the map
        counter = teamCountMap[teamName]! + 1;
        teamCountMap[teamName] = counter;
      } else {
        // Add team name to the map with count 1 if it doesn't exist
        teamCountMap[teamName] = {};
      }
    }

    // Create a list of widgets based on the processed data
    List<Map<String, dynamic>> result = [];
    teamCountMap.forEach((teamName, data) {
      result.add({
        'teamName': teamName,
        'count': counter,
        'completionStatus': data['completionStatus'],
        'assignmentTime': data['assignmentTime'],
      });
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (listAssignments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    List<Map<String, dynamic>> teamDataList = processAssignments();
    List<Widget> gridAssignments = getGridViewAssignments(teamDataList);

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

  List<Widget> getGridViewAssignments(List<Map<String, dynamic>> lc) {
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

  Widget getItemViewGrid(Map<String, dynamic> s) {
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
                s['teamName'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    s['completionStatus'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red[100],
                    ),
                  )
                ],
              ),
              Text(
                "Count: ${s['count']}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Text(
                "Assignment Time: ${s['assignmentTime']}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
