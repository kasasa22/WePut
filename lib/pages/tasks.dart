// ignore_for_file: avoid_print, library_private_types_in_public_api, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:maker/services/user.dart';

import '../adapters/task_list_adapter.dart';
import '../firebase_user.dart';
import '../models/assignment.dart';
import '../models/notification.dart';
import '../models/task.dart';
import '../services/assignment.dart';
import '../services/notification.dart';
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
    // Call listenToTasks method to fetch tasks from Firebase
    //listenToTasks();
    // Fetch current user information
    fetchCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  List<Task> assignedTasks = [];
  List<Task> inProgressTasks = [];
  List<Task> completedTasks = [];
  List<Task> tasks = [];
  List<Task> items = [];

//-------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------
  Future<String?> getUserIdByEmail(String email) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming there is only one document for a unique email
        String userId = userQuery.docs.first.id;
        return userId;
      } else {
        // User not found
        return null;
      }
    } catch (error) {
      print("Error getting user ID: $error");
      return null;
    }
  }

  Future<List<String>> getAssignmentIdsForUser(String userId) async {
    try {
      QuerySnapshot assignmentQuery = await FirebaseFirestore.instance
          .collection('assignments')
          .where('userId', isEqualTo: userId)
          .get();

      List<String> assignmentIds =
          assignmentQuery.docs.map((doc) => doc.id).toList();
      return assignmentIds;
    } catch (error) {
      print("Error getting assignment IDs: $error");
      return [];
    }
  }

// Updated getTasksForAssignments function
  Future<List<Task>> getTasksForAssignments(List<String> assignmentIds) async {
    List<String> taskIds = [];
    try {
      for (String assignmentId in assignmentIds) {
        DocumentSnapshot assignmentDoc = await FirebaseFirestore.instance
            .collection('assignments')
            .doc(assignmentId)
            .get();

        // Check if the assignment document exists
        if (assignmentDoc.exists) {
          // Retrieve the task ID from the assignment document
          String taskId = assignmentDoc
              .get('taskId'); // Replace 'taskId' with the actual field name

          // Add the task ID to the list
          taskIds.add(taskId);

          print(
              "============+++++++++++++++++++gasrcjkghdfbmjhjg+++++++++++++++++++++++++");
          print(taskIds);
        }
      }
    } catch (e) {
      print(e);
    }

    try {
      for (String taskId in taskIds) {
        DocumentSnapshot taskDoc = await FirebaseFirestore.instance
            .collection('tasks')
            .doc(taskId)
            .get();

        if (taskDoc.exists) {
          Task task = Task(
            assignedUserId: taskDoc.get('assignedUserId'),
            category: taskDoc.get('category'),
            comments: taskDoc.get('comments'),
            description: taskDoc.get('description'),
            dueDate: taskDoc.get('dueDate'),
            endTime: taskDoc.get('endTime'),
            evaluation: taskDoc.get('evaluation'),
            priority: taskDoc.get('priority'),
            progress: taskDoc.get('progress'),
            startTime: taskDoc.get('startTime'),
            status: taskDoc.get('status'),
            taskId: taskDoc.get('taskId'),
            title: taskDoc.get('title'),
          );
          tasks.add(task);
        }
      }

      // print(
      //     "====================================================================================================");
      // print(tasks.toList());

      // for (var task in tasks) {
      //   print(task.assignedUserId);
      //   print(task.comments);
      //   print(task.title);
      //   print(task.priority);
      // }

      return tasks;
    } catch (error) {
      print("Error getting tasks: $error");
      return [];
    }
  }

  void fetchDataForUser(String userEmail) async {
    String? userId = await getUserIdByEmail(userEmail);

    if (userId != null) {
      List<String> assignmentIds = await getAssignmentIdsForUser(userId);
      List<Task> tasks = await getTasksForAssignments(assignmentIds);
      // List<Task> newTasks = await listToNewTasks();

      print(
          "-----------------------------------------------------THE ITEMS ----------------------------------------------------------------------------");
      print(items);

      // print(assignmentIds);

      print(
          "-----------------------------------------------------THE TASKS ----------------------------------------------------------------------------");
      print("Tasks: $tasks");
      // Call listenToTasks method to fetch tasks from Firebase
      listenToTasks();
      // listToNewTasks();
    } else {
      print("User not found.");
    }
  }

// New fetchCurrentUser function
  void fetchCurrentUser() async {
    try {
      // Step 1: Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userEmail = user.email!;
        print(
            'User Email-------------------------------------------------------------------------------------------------------------------------------------------------: $userEmail');
        fetchDataForUser(userEmail);
      } else {
        print('User not authenticated.');
      }
    } catch (error) {
      print("Error fetching current user: $error");
    }
  }

//-------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------
  void listenToTasks() {
    assignedTasks.clear();
    inProgressTasks.clear();
    completedTasks.clear();

    for (var task in tasks) {
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

    // TaskService taskService = TaskService();
    // taskService.getTasks().listen((QuerySnapshot snapshot) {
    //   // Clear existing lists
    //   assignedTasks.clear();
    //   inProgressTasks.clear();
    //   completedTasks.clear();

    //   for (var document in snapshot.docs) {
    //     Task task = Task(
    //       taskId: document.id,
    //       title: document['title'],
    //       description: document['description'],
    //       dueDate: document['dueDate'],
    //       status: document['status'],
    //       assignedUserId: document['assignedUserId'],
    //       priority: document['priority'],
    //       category: document['category'],
    //       progress: document['progress'],
    //       comments: document['comments'],
    //       startTime: document['startTime'],
    //       endTime: document['endTime'],
    //       evaluation: document['evaluation'],
    //     );

    //     // Categorize tasks based on their status
    //     if (task.status == 'Assigned') {
    //       assignedTasks.add(task);
    //     } else if (task.status == 'In-Progress') {
    //       inProgressTasks.add(task);
    //     } else if (task.status == 'Completed') {
    //       completedTasks.add(task);
    //     }
    //   }

    //   // Use setState to trigger a rebuild with the updated lists
    //   setState(() {});
    // });
  }

  // String getCurrentUserId() {
  //   Map<String, dynamic> userData = getCurrentUserData();
  //   print(
  //       "Current user data----------------------------------------------------------------------------------------------------------: $userData");
  //   return userData['uid']; // Use square brackets to access the value
  // }

  // Future<List<Task>> listToNewTasks() async {
  //   // Get the currently logged-in user's information
  //   String userId = getCurrentUserId();

  //   try {
  //     QuerySnapshot newTasksQuery = await FirebaseFirestore.instance
  //         .collection('tasks')
  //         .where('assignedUserId', isEqualTo: userId)
  //         .where("status", isEqualTo: "Assigned")
  //         // .where("status", isEqualTo: "In-Progress")
  //         // .where("status", isEqualTo: "Completed")
  //         .get();

  //     // Map the query snapshot to a List<Task>
  //     List<Task> assignedTasks = newTasksQuery.docs.map((doc) {
  //       return Task(
  //         assignedUserId: doc.id,
  //         category: doc["category"],
  //         comments: ["comments"],
  //         description: doc["description"],
  //         dueDate: doc["dueDate"],
  //         endTime: doc["endTime"],
  //         evaluation: doc["evaluation"],
  //         priority: doc["priority"],
  //         progress: doc["progress"],
  //         startTime: doc["startTime"],
  //         status: doc["status"],
  //         taskId: doc["taskId"],
  //         title: doc["title"],
  //       );
  //     }).toList();

  //     // Print or use assignedTasks as needed
  //     print("Assigned Tasks: $assignedTasks");

  //     // Return the list of assigned tasks
  //     return assignedTasks;
  //   } catch (error) {
  //     print("Error :: $error");
  //     return []; // Return an empty list in case of an error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
          showSheet(context, items);
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
                  itemCount: assignedTasks.length,
                  itemBuilder: (context, index) {
                    if (assignedTasks.isNotEmpty) {
                      return TaskTile(
                        index: index,
                        task: assignedTasks[index],
                        leadingColor: Colors.red,
                        onAddPeople: () {
                          AddPeopleSheet(context, items.cast<User>(),
                              assignedTasks[index].taskId);
                        },
                        onComplete: () {
                          updateTaskStatusNew(
                              assignedTasks[index].taskId, 'In-Progress');
                        },
                      );
                    }
                    return Center(
                      child: Text("No Tasks"),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: inProgressTasks.length,
                  itemBuilder: (context, index) {
                    if (inProgressTasks.isNotEmpty) {
                      return TaskTile(
                        index: index,
                        task: inProgressTasks[index],
                        leadingColor: Colors.yellow,
                        onAddPeople: () {
                          AddPeopleSheet(context, items.cast<User>(),
                              inProgressTasks[index].taskId);
                        },
                        onComplete: () {
                          updateTaskStatusOld(
                              inProgressTasks[index].taskId, 'Completed');
                        },
                      );
                    }
                    return Center(
                      child: Text("No Tasks"),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    if (completedTasks.isNotEmpty) {
                      return TaskTile(
                        index: index,
                        task: completedTasks[index],
                        leadingColor: Colors.green,
                        onComplete: () {
                          // Handle completion action
                        },
                      );
                    } else {
                      return Center(
                        child: Text("No Tasks"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTaskStatusNew(String taskID, String status) {
    print(
        "updateTaskStatusNew>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(taskID);
    print(status);
    TaskService taskService = TaskService();
    Task? updatedTask =
        assignedTasks.firstWhereOrNull((task) => task.taskId == taskID);

    if (updatedTask != null) {
      updatedTask.status = status;
      taskService.updateTask(taskID, updatedTask);
    } else {
      print("Task with ID $taskID not found.");
      // Handle the case where the task is not found.
    }
  }

  void updateTaskStatusOld(String taskID, String status) {
    TaskService taskService = TaskService();
    Task? updatedTask =
        inProgressTasks.firstWhereOrNull((task) => task.taskId == taskID);

    if (updatedTask != null) {
      updatedTask.status = status;
      taskService.updateTask(taskID, updatedTask);
    } else {
      print("Task with ID $taskID not found.");
      // Handle the case where the task is not found.
    }
  }

  void showSheet(context, List<Task> items) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return TaskSheet(
          selectedDate: _selectedDate,
          items: items, // Pass items to TaskSheet
          onTaskAdded: (Task newTask) {
            setState(() {
              items.add(newTask);
            });
          },
        );
      },
    );
  }

  void AddPeopleSheet(context, List<User> items, String taskId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        // Pass the task ID to the _AddPeopleSheet widget
        return _AddPeopleSheet(taskId: taskId);
      },
    );
  }
}

class _AddPeopleSheet extends StatefulWidget {
  final String taskId; // Add task ID as a parameter

  const _AddPeopleSheet({required this.taskId});

  @override
  _AddPeopleSheetState createState() => _AddPeopleSheetState();
}

class _AddPeopleSheetState extends State<_AddPeopleSheet> {
  late List<String> people; // This will be updated with the StreamBuilder
  late List<bool> selectedPeople;
  late List<String> selectedUserIds; // New list to store checked user IDs
  late TextEditingController
      messageController; // New controller for the message

  late TextEditingController teamController; // New controller for the message

  UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    // Initialize selectedUserIds list
    selectedUserIds = [];
    // Fetch users from the stream
    people = []; // Initially empty until the stream updates
    selectedPeople = List.filled(people.length, false);
    // Initialize the message controller
    messageController = TextEditingController();
    teamController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add People to Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Add a text box for the message
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message to People',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add a text box for the message
            TextField(
              controller: teamController,
              decoration: InputDecoration(
                labelText: 'Team Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: _userService.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Update the people list and selectedPeople list
                people = snapshot.data!.docs
                    .map<String>((DocumentSnapshot document) =>
                        document['name'].toString())
                    .toList();
                selectedPeople = List.filled(people.length, false);

                // Filter out selected names from the list
                List<String> filteredPeople = people
                    .where((name) => !selectedUserIds
                        .contains(snapshot.data!.docs[people.indexOf(name)].id))
                    .toList();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < filteredPeople.length; i++)
                        ListTile(
                          title: Text(filteredPeople[i]),
                          leading: Checkbox(
                            value: selectedPeople[i],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedPeople[i] = value!;
                                // Capture the ID of the document
                                if (value) {
                                  selectedUserIds
                                      .add(snapshot.data!.docs[i].id);
                                } else {
                                  selectedUserIds
                                      .remove(snapshot.data!.docs[i].id);
                                }
                              });
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                        ),
                        onPressed: () {
                          if (selectedPeople.isNotEmpty &&
                              teamController.text.isNotEmpty &&
                              messageController.text.isNotEmpty) {
                            // Use the selectedUserIds list and messageController.text as needed
                            print('Selected Document IDs: $selectedUserIds');
                            print(
                                'Message to People: ${messageController.text}');
                            print(
                                'team------------------------------------------------------------- to People: ${teamController.text}');
                            print('Task ID: ${widget.taskId}');

                            // Create a new Notification object
                            Message newNotification = Message(
                              notificationId:
                                  'notificationID', // Assign a unique ID, or leave it empty if Firestore generates one
                              userId: '',
                              message: messageController.text,
                              timestamp: Timestamp.now(),
                              viewed: false, // Set the initial viewed status
                            );

                            // Create a new Assignment object
                            Assignment newAssignment = Assignment(
                              teamName: teamController.text,

                              userId: '',
                              taskId: widget.taskId,
                              assignmentTime: Timestamp.now(),
                              completionStatus:
                                  'Pending', // You can set this to an initial status
                            );

                            // Loop through selectedUserIds and add notifications and assignments for each user
                            for (String userId in selectedUserIds) {
                              newNotification.userId = userId;
                              newAssignment.userId = userId;

                              // Use the AssignmentService to add the assignment to Firebase
                              AssignmentService assignmentService =
                                  AssignmentService();
                              assignmentService.addAssignment(newAssignment);

                              // Use the NotificationService to add the notification to Firebase
                              NotificationService notificationService =
                                  NotificationService();
                              notificationService
                                  .addNotification(newNotification);
                            }
                          }

                          // Close the bottom sheet
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Add Selected People',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskSheet extends StatefulWidget {
  DateTime? selectedDate; // Declare selectedDate as a parameter
  List<Task> items; // Declare items as a parameter
  Function(Task) onTaskAdded; // Declare onTaskAdded as a parameter

  TaskSheet({
    Key? key,
    required this.selectedDate,
    required this.items,
    required this.onTaskAdded,
  }) : super(key: key);

  @override
  _TaskSheetState createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late String selectedPriority = 'High';
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
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
                        // Update the selectedPriority variable when the value changes
                        setState(() {
                          selectedPriority = value!;
                        });
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
                    if (descriptionController.text.isNotEmpty &&
                        titleController.text.isNotEmpty) {
                      _addTask();
                    }
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
      taskId: userId,
      title: titleController.text,
      description: descriptionController.text,
      dueDate: widget.selectedDate != null
          ? Timestamp.fromDate(widget.selectedDate!)
          : Timestamp.now(),
      status: 'Assigned',
      assignedUserId: userId,
      priority: selectedPriority,
      category: 'General',
      progress: 0,
      comments: [], // Start with an empty list of comments
      startTime: widget.selectedDate != null
          ? Timestamp.fromDate(widget.selectedDate!)
          : Timestamp.now(),
      endTime:
          Timestamp.now(), // Set to the current date as the default end time
      evaluation: 0.0,
    );

    // Use the TaskService to add the task to Firebase
    taskService.addTask(newTask);

    // Add the new task to the items list
    widget.onTaskAdded(newTask);

    // Clear the input fields after adding the task
    titleController.clear();
    descriptionController.clear();

    // You can add any additional logic after the task is successfully added
    print(
        'Task added successfully!-------------------------------------------------------------------------------------------------');
  }

  // Replace with your method to get the currently logged-in user's ID
  String getCurrentUserId() {
    Map<String, dynamic> userData = getCurrentUserData();
    print(
        "Current user data----------------------------------------------------------------------------------------------------------: $userData");
    return userData['uid']; // Use square brackets to access the value
  }
}
