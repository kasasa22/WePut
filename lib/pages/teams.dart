import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/models/assignment.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    List<Assignment> listAssignments = [
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
      Assignment(
          assignmentId: "njsfd",
          userId: "hsjvjdt",
          taskId: "hgfkkj",
          assignmentTime: Timestamp(2, 4),
          completionStatus: "nx,dvhjxj"),
    ];
    List<Widget> gridAssignments = getGridViewAssignments(listAssignments);
    return Scaffold(
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
                child: Image.asset(
                  "assets/images/drawer.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                height: 200,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Here are the Teams that you are part of\n you can browse through",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
    for (int i = 0; i < lc.length / 2; i++) {
      Widget w;
      w = Row(
        children: [
          getItemViewGrid(lc[i * 2]),
          Container(width: 2),
          if (lc.length > 1 && lc.length < 8) getItemViewGrid(lc[(i * 2) + 1]),
          if (lc.length > 8) getItemViewGrid(lc[(i * 2) + 2]),
        ],
      );

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
                      color: Colors.grey[600],
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
