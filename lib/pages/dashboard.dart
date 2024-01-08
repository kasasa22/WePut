import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/dashboard/line_chart.dart';
import 'package:maker/components/dashboard/pie_chart.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/components/home/stat_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const ColoredBox(
              color: Colors.white10,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Hi, Ambrose, You are welcome",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
                      title: 'boards',
                      icon: Icons.book_online_outlined,
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

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Text widgets forming lists
                  const Text(
                    "My Team performance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                    "Teams with tasks graph analysis",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              "Development Team",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              "Digital Marketing Team",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              "Product Design Team",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Group Team",
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
