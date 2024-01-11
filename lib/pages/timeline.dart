// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/dashboard/TaskCard.dart';
import '../components/dashboard/pie_chart.dart';
import '../components/drawer.dart';
import '../models/task.dart';
import '../services/task.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> with TickerProviderStateMixin {
  List<Task> assignedTasks = [];
  List<Task> inProgressTasks = [];
  List<Task> completedTasks = [];

  @override
  void initState() {
    // Call listenToTasks method to fetch tasks from Firebase
    listenToTasks();
    super.initState();
  }

  void listenToTasks() {
    TaskService taskService = TaskService();
    taskService.getTasks().listen((QuerySnapshot snapshot) {
      // Clear existing lists
      assignedTasks.clear();
      inProgressTasks.clear();
      completedTasks.clear();

      for (var document in snapshot.docs) {
        Task task = Task(
          taskId: document.id,
          title: document['title'],
          description: document['description'],
          dueDate: document['dueDate'],
          status: document['status'],
          assignedUserId: document['assignedUserId'],
          priority: document['priority'],
          category: document['category'],
          progress: document['progress'],
          comments: document['comments'],
          startTime: document['startTime'],
          endTime: document['endTime'],
          evaluation: document['evaluation'],
        );

        // Categorize tasks based on their status
        if (task.status == 'Assigned') {
          assignedTasks.add(task);
        } else if (task.status == 'In-Progress') {
          inProgressTasks.add(task);
        } else if (task.status == 'Completed') {
          completedTasks.add(task);
        }
      }

      // Use setState to trigger a rebuild with the updated lists
      setState(() {});
    });
  }

  final List<dynamic> _furnitures = [
    {
      'title': 'Track your \nTasks',
      'sub_title':
          'Assign, Track and Do your Tasks on the go. All in one place!.',
      'image':
          'https://images.unsplash.com/photo-1612015900986-4c4d017d1648?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTJ8fGZ1cm5pdHVyZXN8ZW58MHx8MHxibGFja3w%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
    },
    {
      'title': 'Track your \nTasks',
      'sub_title':
          'Assign, Track and Do your Tasks on the go. All in one place!.',
      'image':
          'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnVybml0dXJlc3xlbnwwfDF8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
    },
    {
      'title': 'Track your \nTasks',
      'sub_title':
          'Assign, Track and Do your Tasks on the go. All in one place!.',
      'image':
          'https://images.unsplash.com/photo-1532499012374-fdfae50e73e9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZnVybml0dXJlc3xlbnwwfDF8MHxibGFja3w%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
    },
    {
      'title': 'Track your \nTasks',
      'sub_title':
          'Assign, Track and Do your Tasks on the go. All in one place!.',
      'image':
          'https://images.unsplash.com/photo-1633555715049-0c2777ee516e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTl8fGZ1cm5pdHVyZXN8ZW58MHwxfDB8YmxhY2t8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60'
    }
  ];

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 20), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animation = Tween<double>(begin: 1.0, end: 1.5)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Timeline"),
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: TimelineHeader(
                controller: _controller,
                animation: _animation,
                furnitures: _furnitures,
              ),
            ),
            const SizedBox(height: 1),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total tasks done",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("over the past 7 days"),
                          ],
                        ),

                        // The graph
                        LimitedBox(
                          maxHeight: 60,
                          child: PieChartWidget(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "TIMELINES",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Adjust the color as needed
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 2,
                          color: Colors.blue, // Adjust the color as needed
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 0.2), // Add border color
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Scheduled",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: ListView.builder(
                                  itemCount: assignedTasks.length,
                                  itemBuilder: (context, index) {
                                    if (assignedTasks.isNotEmpty) {
                                      return CustomCard(
                                          icon: Icons.task_sharp,
                                          cardColor: Colors.lightGreenAccent,
                                          title: assignedTasks[index].title,
                                          taskDate: assignedTasks[index]
                                              .dueDate
                                              .toString(),
                                          isCompleted: false,
                                          cardHeight: 50,
                                          cardWidth: 300.0);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 0.2), // Add border color
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "In Progress",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: inProgressTasks.length,
                                  itemBuilder: (context, index) {
                                    if (inProgressTasks.isNotEmpty) {
                                      return CustomCard(
                                          icon: Icons.add_task_outlined,
                                          cardColor: Colors.lightGreen,
                                          title: inProgressTasks[index].title,
                                          taskDate: inProgressTasks[index]
                                              .dueDate
                                              .toString(),
                                          isCompleted: false,
                                          cardHeight: 50,
                                          cardWidth: 300.0);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 0.2), // Add border color
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: completedTasks.length,
                                  itemBuilder: (context, index) {
                                    if (completedTasks.isNotEmpty) {
                                      return CustomCard(
                                          icon: Icons.mark_chat_read_sharp,
                                          cardColor: Colors.green,
                                          title: completedTasks[index].title,
                                          taskDate: completedTasks[index]
                                              .dueDate
                                              .toString(),
                                          isCompleted: true,
                                          cardHeight: 50,
                                          cardWidth: 300.0);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineHeader extends StatelessWidget {
  const TimelineHeader({
    super.key,
    required AnimationController controller,
    required Animation<double> animation,
    required List furnitures,
  })  : _controller = controller,
        _animation = animation,
        _furnitures = furnitures;

  final AnimationController _controller;
  final Animation<double> _animation;
  final List _furnitures;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (int index) {
        _controller.value = 0.0;
        _controller.forward();
      },
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: ScaleTransition(
                scale: _animation,
                child: Image.network(
                  _furnitures[index]['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.1)
                  ])),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _furnitures[index]['title'],
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        FadeInDown(
                            delay: const Duration(milliseconds: 100),
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              _furnitures[index]['sub_title'],
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 1000),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                onPressed: () {},
                                color: Colors.orange,
                                padding: const EdgeInsets.only(
                                    right: 5, left: 30, top: 5, bottom: 5),
                                child: SizedBox(
                                  height: 15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/tasks');
                                        },
                                        child: Text(
                                          'Get Started',
                                          style: TextStyle(
                                            color: Colors.orange.shade50,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(height: 2),
                      ])),
            )
          ],
        );
      },
      itemCount: _furnitures.length,
      controller: PageController(viewportFraction: 1.0),
    );
  }
}
