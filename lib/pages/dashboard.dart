// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/dashboard/stat_card.dart';
import 'package:maker/components/drawer.dart';

import '../models/assignment.dart';
import '../models/task.dart';
import '../services/assignment.dart';
import '../services/task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // crate list of spots for the graph by monthly, yearly of Google Stocks
  final List<FlSpot> _daylySpots = [
    const FlSpot(0, 2.0),
    const FlSpot(1, 2.0),
    const FlSpot(2, 3.0),
    const FlSpot(3, 1.0),
    const FlSpot(4, 4.0),
    const FlSpot(5, 6.0),
    const FlSpot(6, 4.0),
    const FlSpot(7, 8.0),
    const FlSpot(8, 6.0),
    const FlSpot(9, 7.0),
    const FlSpot(10, 5.0),
    const FlSpot(11, 15.0),
    const FlSpot(12, 7.0),
    const FlSpot(13, 8.0),
    const FlSpot(14, 6.0),
    const FlSpot(15, 7.0),
    const FlSpot(16, 6.0),
    const FlSpot(17, 8.0),
    const FlSpot(18, 11.0),
    const FlSpot(19, 13.0),
    const FlSpot(20, 10.0),
    const FlSpot(21, 13.0),
    const FlSpot(22, 16.0),
    const FlSpot(23, 19.0),
    const FlSpot(24, 15.0),
    const FlSpot(25, 17.0),
    const FlSpot(26, 18.0),
    const FlSpot(27, 14.0),
    const FlSpot(28, 15.0),
    const FlSpot(29, 15.0),
    const FlSpot(30, 13.0)
  ];

  final List<FlSpot> _monthlySpots = [
    const FlSpot(0, 55.0),
    const FlSpot(1, 55.0),
    const FlSpot(2, 66.0),
    const FlSpot(3, 50.0),
    const FlSpot(4, 65.0),
    const FlSpot(5, 80.0),
    const FlSpot(6, 90.0),
    const FlSpot(7, 75.0),
    const FlSpot(8, 78.0),
    const FlSpot(9, 80.0),
    const FlSpot(10, 70.0),
    const FlSpot(11, 76.0),
  ];

  int _currentIndex = 0;

  int selectedTool = 0;

  List<dynamic> tools = [
    {
      'image': 'https://cdn-icons-png.flaticon.com/128/732/732244.png',
      'selected_image': 'https://cdn-icons-png.flaticon.com/128/732/732244.png',
      'name': 'Sketch',
      'description': 'The digital design platform.',
    },
    {
      'image': 'https://img.icons8.com/color/2x/adobe-xd.png',
      'selected_image': 'https://img.icons8.com/color/2x/adobe-xd--v2.gif',
      'name': 'Adobe XD',
      'description': 'Fast & powerful UI/UX design solution.',
    },
    {
      'image': 'https://img.icons8.com/color/2x/figma.png',
      'selected_image': 'https://img.icons8.com/color/2x/figma--v2.gif',
      'name': 'Figma',
      'description': 'The collaborative interface design tool.',
    }
  ];

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
  AssignmentService taskService = AssignmentService();
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

        // print(
        //     "----------------------------------------------------------------------------------");

        // print(listAssignmentsNew);
      }
    }

    // Now listAssignmentsNew contains unique team names with combined completion statuses
    setState(() {});
  }

  List<Task> assignedTasks = [];
  List<Task> inProgressTasks = [];
  List<Task> completedTasks = [];

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

      // print(completedTasks);
      // Use setState to trigger a rebuild with the updated lists
      setState(() {});
    });
  }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  void initState() {
    fetchNotificationsForCurrentUser();
    fetchTeams();
    listenToTasks();
    super.initState();
  }

  void fetchNotificationsForCurrentUser() async {
    // Step 1: Get the current user's email
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      print('User Email-----------------------: $userEmail');

      // Step 2: Query the users collection to get the user's document ID
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming there is only one document for a unique email
        String userId = userQuery.docs.first.id;

        // Step 5: Use the obtained userId to query the user's document and get the name
        DocumentSnapshot userDocument = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDocument.exists) {
          String userName = userDocument['name'];
          print('User Name: $userName');
          setState(() {
            name = userName;
          });
          name = userName;
        } else {
          print('User document not found.');
        }
      } else {
        print('User not found.');
      }
    } else {
      print('User not authenticated.');
    }
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    print("User Name: ---------");
    name = name;
    print(name);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Dashboard"),
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
                    // sign out the user
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
      // Drawer
      drawer: const MyDrawer(),

      // Body
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: 10,
              ),
              ColoredBox(
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Hi, $name \n Welcome to your Dashboard",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Add more dashboard content here
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      //navigate to the inbox page
                      Navigator.pushNamed(context, '/inbox');
                    },
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      //navigate to the settings page
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Add more Positioned widgets for additional elements
            ],
          ),
          Container(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Cards with an icon at the top and a word at the bottom.
                  statCard(
                    title: 'Assigned tasks',
                    icon: Icons.task_alt_sharp,
                    subtitle: assignedTasks.length.toString(),
                  ),
                  statCard(
                    title: 'Scheduled tasks',
                    icon: Icons.task_alt_outlined,
                    subtitle: inProgressTasks.length.toString(),
                  ),
                  statCard(
                    title: 'Completed tasks',
                    icon: Icons.add_task_sharp,
                    subtitle: completedTasks.length.toString(),
                  ),
                  statCard(
                    title: 'Assignment Teams',
                    icon: Icons.people,
                    subtitle: listAssignmentsNew.length.toString(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // The graph

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              from: 30,
                              child: Text(
                                'TASKS DONE',
                                style: TextStyle(
                                  color: Colors.blueGrey.shade100,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              from: 30,
                              child: const Text(
                                '+20.5%',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              from: 60,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: LineChart(
                                  mainData(),
                                  swapAnimationCurve: Curves.easeInOutCubic,
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = 0;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _currentIndex == 0
                                            ? const Color(0xff161b22)
                                            : const Color(0xff161b22)
                                                .withOpacity(0.0),
                                      ),
                                      child: Text(
                                        "D",
                                        style: TextStyle(
                                            color: _currentIndex == 0
                                                ? Colors.blueGrey.shade200
                                                : Colors.blueGrey,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = 1;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _currentIndex == 1
                                            ? const Color(0xff161b22)
                                            : const Color(0xff161b22)
                                                .withOpacity(0.0),
                                      ),
                                      child: Text(
                                        "M",
                                        style: TextStyle(
                                            color: _currentIndex == 1
                                                ? Colors.blueGrey.shade200
                                                : Colors.blueGrey,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = 2;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _currentIndex == 2
                                            ? const Color(0xff161b22)
                                            : const Color(0xff161b22)
                                                .withOpacity(0.0),
                                      ),
                                      child: Text(
                                        "Y",
                                        style: TextStyle(
                                            color: _currentIndex == 2
                                                ? Colors.blueGrey.shade200
                                                : Colors.blueGrey,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
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
                    Text("View by Day, Month, and Year"),
                  ],
                ),
                Icon(
                  Icons.auto_graph,
                  size: 15,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                FadeInDown(
                  from: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select a Design Tool",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  from: 50,
                  child: Text(
                    "Want to complete tasks Faster?",
                    style: TextStyle(
                        color: Colors.blueGrey.shade400, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    itemCount: tools.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTool = index;
                          });
                        },
                        child: FadeInUp(
                          delay: Duration(milliseconds: index * 100),
                          child: AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 20),
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: selectedTool == index
                                        ? Colors.blue
                                        : Colors.white.withOpacity(0),
                                    width: 2),
                                boxShadow: [
                                  selectedTool == index
                                      ? BoxShadow(
                                          color: Colors.blue.shade100,
                                          offset: const Offset(0, 3),
                                          blurRadius: 10)
                                      : BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: const Offset(0, 3),
                                          blurRadius: 10)
                                ]),
                            child: Row(
                              children: [
                                selectedTool == index
                                    ? Image.network(
                                        tools[index]['selected_image'],
                                        width: 50,
                                      )
                                    : Image.network(
                                        tools[index]['image'],
                                        width: 50,
                                      ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tools[index]['name'],
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        tools[index]['description'],
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: selectedTool == index
                                      ? Colors.blue
                                      : Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // Charts Data
  List<Color> gradientColors = [
    const Color(0xffe68823),
    const Color(0xffe68823),
  ];

  LineChartData mainData() {
    return LineChartData(
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
          show: false, horizontalInterval: 1, drawVerticalLine: true),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 8),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'JAN';
              case 2:
                return 'FEB';
              case 3:
                return 'MAR';
              case 4:
                return 'APR';
              case 5:
                return 'MAY';
              case 6:
                return 'JUN';
              case 7:
                return 'JUL';
              case 8:
                return 'AUG';
              case 9:
                return 'SEP';
              case 10:
                return 'OCT';
              case 11:
                return 'NOV';
              case 12:
                return 'DEC';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1k';
              case 3:
                return '3k';
              case 5:
                return '5k';
            }
            return '';
          },
        ),
      ),
      minX: 0,
      maxX: _currentIndex == 0
          ? _daylySpots.length - 1.toDouble()
          : _currentIndex == 1
              ? _monthlySpots.length - 1.toDouble()
              : _currentIndex == 2
                  ? _daylySpots.length - 20.toDouble()
                  : _daylySpots.length.toDouble(),
      minY: 0,
      maxY: 50,
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 2,
                dashArray: [3, 3],
              ),
              FlDotData(
                show: false,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  color: [
                    Colors.black,
                    Colors.black,
                  ][index],
                  strokeWidth: 2,
                  strokeColor: Colors.black,
                ),
              ),
            );
          }).toList();
        },
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                ' ${touchedSpot.y.round()}',
                const TextStyle(color: Colors.white, fontSize: 12.0),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: _currentIndex == 0
              ? _daylySpots
              : _currentIndex == 1
                  ? _monthlySpots
                  : _daylySpots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradientFrom: const Offset(0, 0),
              gradientTo: const Offset(0, 1),
              colors: [
                const Color(0xffe68823).withOpacity(0.1),
                const Color(0xffe68823).withOpacity(0),
              ]),
        )
      ],
    );
  }
}
