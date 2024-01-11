// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../adapters/basic_list_adapter.dart';
import '../components/drawer.dart';
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

      // Add more messages as needed
    ];

    items.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        leading: const Icon(
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
      drawer: const MyDrawer(),
      body: ListExpandAdapter(items).getView(),
    );
  }
}
