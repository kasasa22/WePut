import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/components/home/stat_card.dart';
import 'package:maker/components/home/task_tile.dart';
import 'package:maker/components/home/teams_card.dart';

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
      drawerScrimColor: const Color.fromARGB(255, 164, 180, 168),

      //Body of all a white background
      body: Expanded(
        child: Column(
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

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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

            const SizedBox(
              height: 5,
            ),

            //list tiles with a title and a subtitle and a trailing icon in a container with a white background and a green border trying to list the upcoming tasks, the completed tasks and the overdue tasks with a top side having these text buttons that can be cliced to toggle between these three catergories and also an elevated button in the same top row that can be clicked to add a new task
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
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
                        width: 2,
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
                        width: 2,
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
                        width: 2,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Add task",
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
              ),
            ),
            //list tiles that will be toggled between depending on the button clicked above
            Container(
              height: 200,
              color: Colors.white,
              child: const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  taskTile(
                    title: 'The first task',
                    description:
                        'The first task incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
                    date: '11/11/23',
                  ),
                  taskTile(
                    title: 'The second task',
                    description:
                        'the second task incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
                    date: '11/11/23',
                  ),
                  taskTile(
                    title: 'The third task',
                    description:
                        'the third task incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
                    date: '11/11/23',
                  ),
                  taskTile(
                    title: 'The last task',
                    description:
                        'the last task lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ',
                    date: '11/`1/23',
                  ),
                  taskTile(
                    title: 'The last task',
                    description:
                        'the last task lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ',
                    date: '11/`1/23',
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //text to describe the teams and an outtline button at the right to add a new team
                  const SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(
                          "Team\nlorem ipsum dolor sit amet, consectetur",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // Add your button press logic here
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add_box_rounded, // Icon you want to display
                              color: Colors.green, // Color of the icon
                            ),
                            SizedBox(width: 8),
                            Text('add team',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //cards with an icon at the top and a word at the bottom and also rectangular in shape and should have a light green background and clear white text
                    teamsCard(
                      title: 'The LyteLink',
                      subtitle: '100',
                    ),
                    teamsCard(
                      title: 'Mosquitos',
                      subtitle: '20',
                    ),
                    teamsCard(
                      title: 'Avengers',
                      subtitle: '200',
                    ),
                    teamsCard(
                      title: 'Marabostock',
                      subtitle: '30',
                    ),
                    teamsCard(
                      title: 'The times',
                      subtitle: '20',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
