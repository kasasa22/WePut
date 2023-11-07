import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/components/home/tasks_list.dart';
import 'package:maker/components/home/tasks_overview.dart';
import 'package:maker/components/home/team_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text("Tasks Home"),
        actions: [
          IconButton(
            onPressed: () {
              //sign out the user
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      //Drawer
      drawer: const MyDrawer(),

      //Body
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1, //spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: [
          //upper section
          //container to display the user's name
          Container(
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text(
                  "Welcome, Aurits",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Simplify Tasks",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          //horizontal scrollable with icons
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Container with icons  for completed tasks
                TasksOverview(
                  icon: Icons.task_outlined,
                  text: 'Completed Tasks',
                ),

                //Container with icons  for pending tasks
                TasksOverview(
                  icon: Icons.task_alt_sharp,
                  text: 'Pending Tasks',
                ),

                //Container with icons  for overdue tasks
                TasksOverview(
                  icon: Icons.task_sharp,
                  text: 'Overdue Tasks',
                ),

                //Container with icons  for upcoming tasks
                TasksOverview(
                  icon: Icons.add_task_sharp,
                  text: 'Upcoming Task',
                ),
              ],
            ),
          ),

          // Divider between sections
          const Divider(thickness: 1.0),
          // Middle section with TasksList
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TasksList(
              tasks: [
                TaskListItem(
                  icon: Icons.work,
                  title: 'Task 1',
                  subtitle: 'Description of Task 1',
                  isCompleted: false,
                ),
                TaskListItem(
                  icon: Icons.shopping_cart,
                  title: 'Task 2',
                  subtitle: 'Description of Task 2',
                  isCompleted: true,
                ),
                // Add more TaskListItem instances as needed
              ],
              taskName: 'Hello ',
            ),
          ),
// Button to add a new task
          ElevatedButton(
            onPressed: () {
              // Handle adding a new task here
            },
            child: const Text("Add Task"),
          ),

          //lower section
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //Team Card 1
                TeamCard(
                  teamName: 'Team name',
                  membersNumber: 5,
                  icon: Icons.people_alt,
                ),

                //Team Card 2
                TeamCard(
                  teamName: 'Team name',
                  membersNumber: 5,
                  icon: Icons.people_alt,
                ),

                //Team Card 3
                TeamCard(
                  teamName: 'Team name',
                  membersNumber: 5,
                  icon: Icons.people_alt,
                ),

                //Team Card 4
                TeamCard(
                  teamName: 'Team name',
                  membersNumber: 5,
                  icon: Icons.people_alt,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
