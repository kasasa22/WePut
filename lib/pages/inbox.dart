// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../adapters/basic_list_adapter.dart';
import '../models/notification.dart';

class ExpandLists extends StatefulWidget {
  const ExpandLists({super.key});

  @override
  State<ExpandLists> createState() => _ExpandListsState();
}

class _ExpandListsState extends State<ExpandLists> {
  @override
  late BuildContext context;
  void onItemClick(int indext, Notification obj) {
    print("onItemClick $indext");
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    List<Message> items = [
      Message(
        notificationId: '1',
        userId: 'user1',
        message: 'Hello from user1!',
        timestamp: Timestamp.now(),
        viewed: false,
      ),
      Message(
        notificationId: '2',
        userId: 'user2',
        message: 'How are you doing?',
        timestamp: Timestamp.now(),
        viewed: true,
      ),
      Message(
        notificationId: '3',
        userId: 'zuser3',
        message: 'Flutter is awesome!',
        timestamp: Timestamp.now(),
        viewed: false,
      ),
      Message(
        notificationId: '4',
        userId: 'ruser4',
        message: 'Working on a new project!',
        timestamp: Timestamp.now(),
        viewed: false,
      ),
      Message(
        notificationId: '5',
        userId: 'fuser5',
        message: 'Any plans for the weekend?',
        timestamp: Timestamp.now(),
        viewed: true,
      ),
      Message(
        notificationId: '6',
        userId: 'huser6',
        message: 'Learning new Flutter features!',
        timestamp: Timestamp.now(),
        viewed: false,
      ),
      Message(
        notificationId: '7',
        userId: 'duser7',
        message: 'Excited about the upcoming event!',
        timestamp: Timestamp.now(),
        viewed: false,
      ),
      Message(
        notificationId: '8',
        userId: 'huser8',
        message: 'Discussing project ideas with the team.',
        timestamp: Timestamp.now(),
        viewed: true,
      ),
      // Add more messages as needed
    ];

    items.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        leading: Icon(
          Icons.menu,
          size: 30,
        ),
        title: const Text("Inbox"),
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
      body: ListExpandAdapter(items).getView(),
    );
  }
}
