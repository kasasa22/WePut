import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

import '../adapters/task_list_adapter.dart';
import '../models/task.dart';

class Boards extends StatefulWidget {
  const Boards({super.key});

  @override
  State<Boards> createState() => _BoardsState();
}

class _BoardsState extends State<Boards> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> items = [
      Task(
        taskId: '1',
        title: 'Complete Flutter App',
        description: 'Finish building the Flutter app for the project.',
        dueDate: Timestamp.now(),
        status: 'In-Progress',
        assignedUserId: 'user1',
        priority: 'High',
        category: 'Development',
        progress: 50,
        comments: ['Comment 1', 'Comment 2'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 4.5,
      ),
      Task(
        taskId: '2',
        title: 'Write Documentation',
        description: 'Document the features and usage of the app.',
        dueDate: Timestamp.now(),
        status: 'Assigned',
        assignedUserId: 'user2',
        priority: 'Medium',
        category: 'Documentation',
        progress: 20,
        comments: ['Comment 3', 'Comment 4'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 3.8,
      ),
      // Add more tasks as needed
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Tasks"),
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
          TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.blue,
            indicatorWeight: 4,
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Text("Assigned"),
              ),
              Tab(
                icon: Text("In-Progress"),
              ),
              Tab(
                icon: Text("Completed"),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
