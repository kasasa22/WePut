import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/dashboard/line_chart.dart';
import 'package:maker/components/dashboard/pie_chart.dart';
import 'package:maker/components/dashboard/stat_card.dart';
import 'package:maker/components/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 10,
                ),
                const ColoredBox(
                  color: Colors.white10,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Ambrose! Welcome to your Dashboard",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
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
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
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
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Add more Positioned widgets for additional elements
              ],
            ),
            Container(
              height: 10,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    //cards with an icon at the top and a word at the bottom and also rectangular in shape and should have a light green background and clear white text
                    statCard(
                      title: 'Assigned tasks',
                      icon: Icons.task_alt_sharp,
                      subtitle: '240',
                    ),
                    statCard(
                      title: 'Completed tasks',
                      icon: Icons.task_alt_outlined,
                      subtitle: '450',
                    ),
                    statCard(
                      title: 'Scheduled tasks',
                      icon: Icons.add_task_sharp,
                      subtitle: '160',
                    ),
                    statCard(
                      title: 'Assignment Teams',
                      icon: Icons.people,
                      subtitle: '490',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
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
                            Icon(
                              Icons.auto_graph,
                              size: 15,
                              color: Colors.black,
                            )
                          ],
                        ),

                        //the graph
                        LimitedBox(
                          maxHeight: 120,
                          child: LineChartWidget(), // Display the line chart)
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Row(
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
                            Icon(
                              Icons.auto_graph,
                              size: 15,
                              color: Colors.black,
                            )
                          ],
                        ),
                        //the graph
                        LimitedBox(
                          maxHeight: 120,
                          child: LineChartWidget(), // Display the pie chart
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),

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
                  Icon(
                    Icons.auto_graph,
                    size: 15,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            //the graph
            const LimitedBox(
              maxHeight: 120,
              child: PieChartWidget(), // Display the pie chart
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
