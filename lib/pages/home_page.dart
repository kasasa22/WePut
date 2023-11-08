import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Tasks Home",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: [
          IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () {
              //sign out the user
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),

      //Drawer
      drawer: const MyDrawer(),
      drawerScrimColor: Color.fromARGB(255, 164, 180, 168),

      //Body of all a white background
      body: Column(
        children: [
          const ColoredBox(
            color: Colors.white10,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Hi, Ambrose, You are almost done",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Please complete a few more steps to get started"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //cards with an icon at the top and a word at the bottom and also rectangular in shape and should have a light green background and clear white text
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.tab_rounded,
                              size: 30,
                              color: Colors.lightGreen,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.tab_rounded,
                              size: 30,
                              color: Colors.lightGreen,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.tab_rounded,
                              size: 30,
                              color: Colors.lightGreen,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.tab_rounded,
                              size: 30,
                              color: Colors.lightGreen,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Create a new board",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // list tiles with a title and a subtitle and a trailing icon in a container with a white background and a green border trying to list the upcoming tasks, the completed tasks and the overdue tasks with a top side having these text buttons that can be cliced to toggle between these three catergories and also an elevated button in the same top row that can be clicked to add a new task

          //list tiles with a title and a subtitle and a trailing icon in a container with a white background and a green border trying to list the upcoming tasks, the completed tasks and the overdue tasks with a top side having these text buttons that can be cliced to toggle between these three catergories and also an elevated button in the same top row that can be clicked to add a new task
          Container(
            color: Colors.white,
            child: Row(
              //stretch the row to fit the screen
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Overdue",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Add a new task",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //list tiles that will be toggled between depending on the button clicked above
          const Column(children: [
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text(
                "Task 1, the title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "11/11/2021 11:00 AM task 1 description",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text(
                "Task 1, the title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "11/11/2021 11:00 AM task 1 description",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text(
                "Task 1, the title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "11/11/2021 11:00 AM task 1 description",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text(
                "Task 1, the title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "11/11/2021 11:00 AM task 1 description",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              //text to describe the teams and an outtline button at the right to add a new team
            ],
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //cards with an icon at the top and a word at the bottom and also rectangular in shape and should have a light green background and clear white text
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.people,
                          size: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "300",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create a new board",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.people,
                          size: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "300",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create a new board",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.people,
                          size: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "300",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create a new board",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.people,
                          size: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "300",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create a new board",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
