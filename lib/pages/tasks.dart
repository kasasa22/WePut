// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

import '../adapters/task_list_adapter.dart';
import '../models/task.dart';
import '../services/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;
  late DateTime? _selectedDate = DateTime.now();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> items = [
      Task(
        taskId: '1',
        title: 'Complete Flutter App',
        description: 'Finish building the Flutter app for the project.',
        dueDate: Timestamp.now(),
        status: 'In-Progress',
        assignedUserId: 'user1',
        priority: 'High',
        category: 'Development',
        progress: 50,
        comments: ['Comment 1', 'Comment 2'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 4.5,
      ),
      Task(
        taskId: '2',
        title: 'Write Documentation',
        description: 'Document the features and usage of the app.',
        dueDate: Timestamp.now(),
        status: 'Assigned',
        assignedUserId: 'user2',
        priority: 'Medium',
        category: 'Documentation',
        progress: 20,
        comments: ['Comment 3', 'Comment 4'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 3.8,
      ),
      // Add more tasks as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Tasks"),
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

      floatingActionButton: FloatingActionButton(
        heroTag: "fab",
        backgroundColor: Colors.pink[500],
        elevation: 3,
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
        ),
        onPressed: () {
          showSheet(context);
        },
      ),

      // Body
      body: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.blue,
            indicatorWeight: 4,
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Text("Assigned"),
              ),
              Tab(
                icon: Text("In-Progress"),
              ),
              Tab(
                icon: Text("Completed"),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return TaskSheet(
          selectedDate: _selectedDate, // Pass _selectedDate to TaskSheet
        );
      },
    );
  }
}

class TaskSheet extends StatefulWidget {
  DateTime? selectedDate; // Declare selectedDate as a parameter

  TaskSheet({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _TaskSheetState createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create New Task",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // Show date picker and update the selected date
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                          cancelText: 'Cancel',
                          confirmText: 'Select',
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: Colors.blue[700],
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.blue,
                                ),
                                buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null &&
                            pickedDate != widget.selectedDate) {
                          setState(() {
                            widget.selectedDate = pickedDate;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Due Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.selectedDate != null
                                  ? "${widget.selectedDate!.toLocal()}"
                                      .split(' ')[0]
                                  : 'Select Date',
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      value: 'High',
                      items: ['High', 'Medium', 'Low']
                          .map((priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(priority),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle the selected priority
                        // Implement your logic here
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                  ),
                  child: const Text(
                    "Create Task",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Handle the task creation logic here
                    // You can retrieve data from the text fields and save it
                    // to your database or perform any other necessary actions.
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTask() {
    final TaskService taskService = TaskService();
    // Get the currently logged-in user's information
    String userId = getCurrentUserId();

    // Create a new task using the input data
    Task newTask = Task(
      taskId: userId + '_' + DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      dueDate:
          Timestamp.now(), // Set to the current date as the default due date
      status: 'Not Started',
      assignedUserId: userId,
      priority:
          getSelectedPriority(), // Replace with your method to get the selected priority from the UI
      category: 'General',
      progress: 0,
      comments: [], // Start with an empty list of comments
      startTime: Timestamp.now(),
      endTime:
          Timestamp.now(), // Set to the current date as the default end time
      evaluation: 0.0,
    );

    // Use the TaskService to add the task to Firebase
    taskService.addTask(newTask);
    // Clear the input fields after adding the task
    titleController.clear();
    descriptionController.clear();

    // You can add any additional logic after the task is successfully added
    print(
        'Task added successfully!-------------------------------------------------------------------------------------------------');
  }

  // Replace with your method to get the currently logged-in user's ID
  String getCurrentUserId() {
    // Your implementation to get the user ID
    return 'user123'; // Replace with your actual implementation
  }

// Replace with your method to get the selected priority from the UI
  String getSelectedPriority() {
    // Your implementation to get the selected priority
    return 'Low'; // Replace with your actual implementation
  }
}
