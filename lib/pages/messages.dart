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

  @override
  void initState() {
    super.initState();
    fetchNotificationsForCurrentUser();
  }

  Future<void> fetchNotificationsForCurrentUser() async {
    // Step 1: Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      print(
          'User Email-------------------------------------------------------------------------------------------------------------------------------------------------: $userEmail');

      // Step 2: Query the users collection to get the user's document ID
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming there is only one document for a unique email
        String userId = userQuery.docs.first.id;

        // Step 3: Use the obtained userId to query notifications
        QuerySnapshot notificationQuery = await FirebaseFirestore.instance
            .collection('notifications')
            .where('userId', isEqualTo: userId)
            .get();

        // Step 4: Process the notifications data
        for (var doc in notificationQuery.docs) {
          print('Notification Message: ${doc['message']}');
          List<Message> notifications = notificationQuery.docs
              .map((doc) => Message(
                    notificationId: doc.id,
                    userId: doc['userId'],
                    message: doc['message'],
                    timestamp: doc['timestamp'],
                    viewed: doc['viewed'],
                  ))
              .toList();

          // Add the fetched notifications to the existing list
          setState(() {
            items.addAll(notifications);
          });
        }
      } else {
        print('User not found.');
      }
    } else {
      print('User not authenticated.');
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
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
